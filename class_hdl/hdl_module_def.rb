

class TdlBuild 
    # return ClassHDL::AnonyModule.new
    def self.method_missing(method,*args,&block)
        
        sdlm = SdlModule.new(name: method,out_sv_path: args[0])
        @@package_names ||= []
        sdlm.head_import_packages = []
        sdlm.head_import_packages += @@package_names

        @@package_names.each do |e|
            sdlm.require_package(e,false) if e
        end
        @@package_names = []
        sdlm.instance_exec(&block)

        if args[0] && File.exist?(args[0])
            sdlm.gen_sv_module
        else 
            sdlm.origin_sv = true 
        end
        sdlm
    end
    ## 定义模块时添加 package

    def self.with_package(*args)
        @@package_names += args
        return self 
    end
end




## 是否实在 itgt 内定义
## $_implicit_curr_itgt_ = []

module ClassHDL

    class ImplicitInstModule

        def initialize(name,sdlm)
            @name = name
            @sdlm = sdlm
        end

        def inst(dname,&block)
            if dname !~ /\w+/
                raise TdlError.new("#{@name} cont instance name #{dname}")
            end

            ## 有必要加一级封装代理
            if $_implicit_curr_itgt_.slast 
                @sdlm.Itgt_Instance(@name,dname.to_s.to_inp,&block)
            else 
                @sdlm.Instance(@name,dname.to_s,&block)
            end
        end

        def method_missing(dname,*args,&block)
            # if dname !~ /\w+/
            #     raise TDLError.new("#{@name} cont instance name #{dname}")
            # end

            # if $_implicit_curr_itgt_.last 
            #     @sdlm.Itgt_Instance(@name,dname.to_s.to_inp,&block)
            # else 
            #     @sdlm.Instance(@name,dname.to_s,&block)
            # end
            AssignDefOpertor.with_rollback_opertors(:old) do 
                inst(dname,&block)
            end
        end

    end
end 

class SdlModule 
    ## 例化模块
    # @@_method_missing_sub_methds ||= []
    # @@_method_missing_sub_methds << 'implicit_inst_module_method_missing'

    def implicit_inst_module_method_missing(method,*args,&block)
        unless $__sdl_curr_self__.respond_to?(method)
            # super 
            ##打通 ITGT 和 module 的方法调用
            if $_implicit_curr_itgt_.slast && $_implicit_curr_itgt_.slast.respond_to?(method)
                return $_implicit_curr_itgt_.slast.send(method,*args)
            else 
                return false 
            end
        end
      
        return ClassHDL::ImplicitInstModule.new(method,self)
    end

end

module ClassHDL

    ## 用于端口定义引入包内结构
    class ImplicitPortBasePackage
        attr_accessor :impl_p_b,:package_name
        def initialize(impl_p_b,package_name)
            @impl_p_b  = impl_p_b
            @package_name = package_name
        end

        def method_missing(method,*args,&block)
            sdlm_pkg = @impl_p_b.sdlm.send(package_name)
            if sdlm_pkg.respond_to? method
                # @impl_p_b.speciel_type = sdlm_pkg.send(method).typedef_name
                @impl_p_b.speciel_type = method
                @impl_p_b.sub_type = sdlm_pkg.send(method)  ## 针对struct 内元素
                @impl_p_b._struct_q = true
                return @impl_p_b
            else 
                raise TdlError.new("Package.struct dont have <#{method}>")
            end
        end
    end

    class ImplicitPortBase
        attr_accessor :chain,:sdlm,:speciel_type,:sub_type,:_struct_q
        def initialize(sdlm,args={})
            @chain = []
            @sdlm = sdlm
            @up_args = args
        end

        def sdlm_port(method=nil,args={})
            raise TDLError.new "ImplicitPortBase slot <#{method}>"
        end

        def logic 
            @speciel_type = 'logic'
            return self
        end

        def wire 
            @speciel_type = 'wire'
            return self 
        end

        def - (name)
            if name !~ /\w+/
                raise TDLError.new("PORT #{name} Illegle ")
            end

            if name.is_a? StringBandItegration
                raise TDLError.new("简化定义模式不允许传入 StringBandItegration 类型")
            end

            args = @up_args
            # @sdlm.Input(method,dsize:args[:dsize] || 1,dimension:args[:dimension]||[],pin:args[:pin]||[],iostd:args[:iostd]||[],pin_prop:args[:pin_prop])
            if $_implicit_curr_itgt_.slast
                name = name.to_inp($_implicit_curr_itgt_.last)
            end

            ## >>>>当使用 chain 定义时忽略 args dimension<<<
            ## 修改成当为struct时 需要不同处理方式
            
            if @chain.any? 
                unless @_struct_q
                    args[:dsize] = @chain.last
                    if @chain[1]
                        args[:dimension] = @chain[0,@chain.size-1]
                    end
                else 
                    args[:dimension] = @chain
                end
            end

            sdlm_port(name,args)
        end

        def clock(*args)
            if args.any?
                if args[0].is_a? Hash 
                    @clock_freqM = args[0][:freqM]
                else 
                    @clock_freqM = args[0]
                end 
            else  
                @clock_freqM = nil
            end
            return self
        end

        def reset(*args)
            if args.any?
                if args[0].is_a? Hash 
                    @reset_active = args[0][:active]
                else 
                    @reset_active = args[0]
                end 
            else  
                @reset_active = nil
            end
            return self
        end

        def method_missing(method,*args,&block)
            ## 检查是否有用户定义的类型数据
            if @sdlm.respond_to?(method)
                if @sdlm.send(method).is_a?(EnumStruct)
                    self.speciel_type = @sdlm.send(method).typedef_name
                    self.sub_type = @sdlm.send(method)  ## 针对struct 内元素
                    self
                elsif @sdlm.send(method).is_a?(StructMeta)
                    self.speciel_type = @sdlm.send(method).name
                    self.sub_type = @sdlm.send(method) ## 针对struct 内元素
                    self
                else 
                    ## 判断 是否是头部引入的包
                    ##  input.<package_name> 返回自身calss
                    # if method.to_s.eql? @sdlm.head_import_package.to_s
                    if @sdlm.head_import_packages.map{ |e| e.to_s }.include?(method.to_s )
                        package_name = method.to_s
                        return ImplicitPortBasePackage.new(self,package_name)
                    else 
                        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
                            args = args[0] || {}
                            @up_args = @up_args.merge(args)
                            self.-(method)
                        end
                    end
                end
            else 
                ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
                    args = args[0] || {}
                    @up_args = @up_args.merge(args)
                    self.-(method)
                end
            end
        end

        def [](*a)
            if a.empty?
                raise TdlError.new("参数不能为空")
            end
            # @chain ||= []
            new_dla = self.class.new(@sdlm,@up_args)
            new_dla.chain = @chain + a
            ## 继承
            new_dla._struct_q = _struct_q
            new_dla.speciel_type = speciel_type
            new_dla.sub_type = sub_type
            new_dla
        end

        def add_struct_method(obj)
            if sub_type.is_a? StructMeta
                @sub_type.struct_slots.each do |e|
                    obj.define_singleton_method(e.name) do 
                        TDLSpace::ArrayChain.new("#{obj.name}.#{e.name}".to_nq)
                    end
                end
            end
        end

    end

    class ImplicitPortInput < ImplicitPortBase


        def sdlm_port(method,args)
            if @clock_freqM
                @sdlm.Clock(method,freqM: @clock_freqM,port: :input,pin:args[:pin]||[],iostd:args[:iostd]||[],dsize:args[:dsize]||1,pin_prop:args[:pin_prop])
            elsif @reset_active
                @sdlm.Reset(method,port: :input,active: @reset_active,pin:args[:pin]||[],iostd:args[:iostd]||[],dsize:args[:dsize]||1,pin_prop:args[:pin_prop])
            else 
                rel = @sdlm.Input(method,dsize:args[:dsize] || 1,dimension:args[:dimension]||[],pin:args[:pin]||[],iostd:args[:iostd]||[],pin_prop:args[:pin_prop])
                rel.type = @speciel_type
                add_struct_method(rel)
                rel
            end
        end
        
    end

    class ImplicitPortOutput < ImplicitPortBase

        def sdlm_port(method,args)
            if @clock_freqM
                @sdlm.Clock(method,freqM: @clock_freqM,port: :output,pin:args[:pin]||[],iostd:args[:iostd]||[],dsize:args[:dsize]||1,pin_prop:args[:pin_prop])
            elsif @reset_active
                @sdlm.Reset(method,port: :output,active: @reset_active,pin:args[:pin]||[],iostd:args[:iostd]||[],dsize:args[:dsize]||1,pin_prop:args[:pin_prop])
            else 
                rel = @sdlm.Output(method,dsize:args[:dsize] || 1,dimension:args[:dimension]||[],pin:args[:pin]||[],iostd:args[:iostd]||[],pin_prop:args[:pin_prop])
                rel.type = @speciel_type
                add_struct_method(rel)
                rel
            end
        end
        
    end

    class ImplicitPortInout < ImplicitPortBase

        def sdlm_port(method,args)
            if @clock_freqM
                @sdlm.Clock(method,freqM: @clock_freqM,port: :inout,pin:args[:pin]||[],iostd:args[:iostd]||[],dsize:args[:dsize]||1,pin_prop:args[:pin_prop])
            elsif @reset_active
                @sdlm.Reset(method,port: :inout,active: @reset_active,pin:args[:pin]||[],iostd:args[:iostd]||[],dsize:args[:dsize]||1,pin_prop:args[:pin_prop])
            else 
                rel = @sdlm.Inout(method,dsize:args[:dsize] || 1,dimension:args[:dimension]||[],pin:args[:pin]||[],iostd:args[:iostd]||[],pin_prop:args[:pin_prop])
                rel.type = @speciel_type
                add_struct_method(rel)
                rel 
            end
        end
        
    end
end

class SdlModule
    ## 例化 input output

    def input(args={})
        return ClassHDL::ImplicitPortInput.new(self,args)
    end

    def output(args={})
        return ClassHDL::ImplicitPortOutput.new(self,args)
    end

    def inout(args={})
        return ClassHDL::ImplicitPortInout.new(self,args)
    end
end 

## 定义 位拼接方法
class SdlModule 

    def >>(*args)
        str = "{>>{#{args.map{|e| e.to_s }.join(',')}}}"
        TDLSpace::ArrayChain.new(str)
    end

    def <<(*args)
        str = "{<<{#{args.map{|e| e.to_s }.join(',')}}}"
        TDLSpace::ArrayChain.new(str)
    end

    def logic_bind_(*args)
        str = "{#{args.map{|e| e.to_s }.join(',')}}"
        TDLSpace::ArrayChain.new(str)
    end

    def clog2(arg)
        str = "$clog2(#{arg.to_s})"
        TDLSpace::ArrayChain.new(str)
    end

    def bits(arg)
        str = "$bits(#{arg.to_s})"
        TDLSpace::ArrayChain.new(str)
    end

end

module ClassHDL
    class ClearSdlModule < SdlModule
        @@id_cnt = 0
        def initialize
            ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
                @@allmodule << self
                @module_name = "clear_board_sdlmodule_#{@@id_cnt}"
                # @real_sv_path = File.join(@out_sv_path,"#{@module_name}.sv") if @out_sv_path
                @dont_gen_sv = true
                @port_clocks        = Hash.new
                @port_resets        = Hash.new
                @port_params        = Hash.new
                @port_logics        = Hash.new
                @port_datainfs      = Hash.new
                @port_datainf_c_s   = Hash.new
                @port_videoinfs     = Hash.new
                @port_axisinfs      = Hash.new
                @port_axi4infs      = Hash.new
                @port_axilinfs      = Hash.new

                # @techbench = TechBench.new
                @sub_instanced = []
                ## --------
                @@ele_array.each do |e|
                    head_str = "@#{e.to_s}"
                    self.instance_variable_set("#{head_str}_collect",[])
                    self.instance_variable_set("#{head_str}_inst",[])
                    self.instance_variable_set("#{head_str}_draw",[])
                    self.instance_variable_set("#{head_str}_pre_inst_stack",[])
                    self.instance_variable_set("#{head_str}_post_inst_stack",[])
                    # tmp = e.new(name:"#{e.to_s}_NC")
                    # tmp.ghost = true
                    # self.instance_variable_set("#{head_str}_NC",tmp)
                end
                create_ghost
                @@id_cnt += 1
            end
        end

        def root_sdlmodule
            unless @belong_to_module
                return nil 
            else  
                if @belong_to_module.is_a?(SdlModule) && !@belong_to_module.is_a?(ClearSdlModule)
                    return @belong_to_module
                else  
                    return @belong_to_module.root_sdlmodule 
                end 
            end
        end
        
    end

end
