module ClassHDL

    class HDLAssignGenerateBlock  

        attr_accessor :opertor_chains

        def initialize
            @opertor_chains = []
        end

        def instance

        end

    end

    class GenerateBlock <  ClearSdlModule
        def initialize(belong_to_module)
            @belong_to_module = belong_to_module
            super()
        end


        def method_missing(name,*args,&block)
            ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do
                ## 优先判断 belong_to_module 有没有定义此方法 
                if root_sdlmodule.respond_to? name 
                    root_sdlmodule.send(name,*args,&block)
                elsif SdlModule.exist_module?(name)
                # puts root_sdlmodule
                # if SdlModule.exist_module?(name)
                    ClassHDL::ImplicitInstModule.new(name,self)
                else
                    @belong_to_module.send(name,*args,&block)
                end
            end
        end

        def IF(cond,&block)
            if ClassHDL::AssignDefOpertor.curr_assign_block.is_a? HDLAssignGenerateBlock
                if cond.respond_to?(:instance)
                    head_str = "\nif(#{cond.instance(:cond)})begin\n"
                else 
                    head_str = "\nif(#{cond})begin\n"
                end
                # yield
                tmp_sm = ClearGenerateSlaverBlock.new(self)
                tmp_sm.instance_exec(&block)
                ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
                    body_str = tmp_sm.instance_draw + tmp_sm.vars_exec_inst
                    gbody_str = body_str.gsub(/^./){ |m| "    #{m}"}
                    self.Logic_inst.push(head_str+gbody_str+"end ")
                end
            else 
                super(cond,&block)
            end
        end

        def ELSIF(cond,&block)
            if ClassHDL::AssignDefOpertor.curr_assign_block.is_a? HDLAssignGenerateBlock
                if cond.respond_to?(:instance)
                    head_str = "else if(#{cond.instance(:cond)})begin\n"
                else 
                    head_str = "else if(#{cond})begin\n"
                end
                # yield
                tmp_sm = ClearGenerateSlaverBlock.new(self)
                tmp_sm.instance_exec(&block)
                ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
                    body_str = tmp_sm.instance_draw + tmp_sm.vars_exec_inst
                    gbody_str = body_str.gsub(/^./){ |m| "    #{m}"}
                    self.Logic_inst.push(head_str+gbody_str+"end\n")
                end
            else 
                super(cond,&block)
            end
        end

        def ELSE(&block)
            if ClassHDL::AssignDefOpertor.curr_assign_block.is_a? HDLAssignGenerateBlock
                head_str = "else begin\n"
                # yield
                tmp_sm = ClearGenerateSlaverBlock.new(self)
                tmp_sm.instance_exec(&block)
                ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
                    body_str = tmp_sm.instance_draw + tmp_sm.vars_exec_inst
                    gbody_str = body_str.gsub(/^./){ |m| "    #{m}"}
                    self.Logic_inst.push(head_str+gbody_str+"end\n")
                end
            else 
                super(&block)
            end
        end
    end 

    class ClearGenerateSlaverBlock < ClearSdlModule
        def initialize(belong_to_module)
            @belong_to_module = belong_to_module
            # @dont_gen_sv = true
            super()
        end

        def method_missing(name,*args,&block)
            ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do
                # puts name
                # puts SdlModule.exist_module?(name)
                # puts @belong_to_module.module_name
                # puts @belong_to_module.respond_to?(name) 
                ## 优先判断 belong_to_module 有没有定义此方法 
                if root_sdlmodule.respond_to? name 
                    root_sdlmodule.send(name,*args,&block)
                elsif SdlModule.exist_module?(name)
                # if SdlModule.exist_module?(name)
                    ClassHDL::ImplicitInstModule.new(name,self)
                else
                    @belong_to_module.send(name,*args,&block)
                end

            end
        end
    end
end

class SdlModule

    def generate(*args,&block)
        head_str = ""
        index = 0

        tmp_sm = ClassHDL::GenerateBlock.new(self)
        kk_args = []

        args.each_index do |e|
            new_op = ClassHDL::OpertorChain.new 
            new_op.tree.push(["KK#{e}".to_nq])
            kk_args << new_op
        end
        ClassHDL::AssignDefOpertor.with_new_assign_block(ClassHDL::HDLAssignGenerateBlock.new ) do 
            ClassHDL::AssignDefOpertor.with_rollback_opertors(:new) do 
                tmp_sm.instance_exec(*kk_args,&block)
            end
        end

        str = (tmp_sm.instance_draw + tmp_sm.vars_exec_inst)

        gstr = generate_block_inst_iterate(str,args)
        head_str = "generate\n"
        end_str  = "endgenerate\n"
        self.Logic_inst << head_str+gstr+end_str
    end

    private 

    def generate_block_inst_iterate(body_str,args)
        index = args.size-1
        bstr = body_str
        args.reverse.each do |arg|
            bstr = generate_block_inst(arg,index=index,bstr)
            index -= 1
        end

        return bstr
    end

    def generate_block_inst(arg=[0,8],index=0,body_str="")
        if arg.respond_to?(:first) && arg.respond_to?(:last)
            start = arg.first
            stop = arg.last 
        else 
            start = 0
            stop = arg
        end

        if start.is_a?(Integer) && stop.is_a?(Integer)
            if start < stop 
                flag = "<"
            else 
                flag = ">"
            end 
        else 
            flag = "<"
        end

        head_str = "for(genvar KK#{index}=#{start};KK#{index} #{flag} #{stop};KK#{index}#{flag=="<" ? '++' : '--'})begin\n"
        gbody_str = body_str.gsub(/^./){ |m| "    #{m}"}

        return head_str+gbody_str+"end\n"
    end
end