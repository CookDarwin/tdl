class TestUnitModule < SdlModule 
    attr_accessor :dve_wave_signals

    def initialize(name: "tdlmodule",out_sv_path: nil)
        super(name: name,out_sv_path: out_sv_path)
        @dve_wave_signals = []
    end

    def test_unit_init(&block)
        Initial do 
            initial_exec("wait(from_up_pass)")
            initial_exec("$root.#{TopModule.current.techbench.module_name}.test_unit_region = \"#{module_name}\"")
            block.call 
            to_down_pass    <= 1.b1
        end
    end

    def add_to_dve_wave(tp,&block)
        # @dve_wave_signals ||= []
        # tps.each do |e|
        #     # dve_wave_signals << e.root_ref.sub("$root.","Sim:")
        #     @dve_wave_signals << e
        # end
        # 
        @dve_wave_signals << tp
        tp.tp_instance.filter_block = block if block_given?
        @dve_wave_signals
    end
end

class TdlTestUnit < TdlBuild 
    # return ClassHDL::AnonyModule.new
    def self.method_missing(method,*args,&block)
        
        sdlm = TestUnitModule.new(name: method,out_sv_path: args[0])

        si = sdlm.input - "from_up_pass"
        so = sdlm.output.logic - "to_down_pass"

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

    # def self.collect_unit(tu)
    #     @@__collect_units__ ||= []
    #     @@__collect_units__ << tu 
    # end

    # def self.echo_units
    #     @@__collect_units__ ||= []
    #     index = 1

    #     rels = []
    #     @@__collect_units__.each do |ue|
    #         rels << "  [#{index}]  #{ue.origin.module_name}"
    #         index += 1
    #     end
    #     rels.join("\n")
    # end

end

class TopModule
    public 
    def add_test_unit(*args)
        @_test_unit_collect_ ||= []
        @_test_unit_collect_ = @_test_unit_collect_ + args
    end

    private 

    def _exec_add_test_unit
        @_test_unit_collect_ ||= []
        args = @_test_unit_collect_
        self.techbench.instance_exec(args) do |args|
            index = 0
            last_index = 0
            logic.string        - 'test_unit_region'
            logic[args.size]    - 'unit_pass_u'
            logic[args.size]    - 'unit_pass_d'

            nqq  = args.size <= 1
            args.each do |tu|
                if tu.is_a? SdlModule
                    _inst_name_ = tu.module_name
                else
                    _inst_name_ = tu.to_s 
                end

                # puts _inst_name_
                # puts SdlModule.call_module(_inst_name_).class
                tu_inst = Instance(_inst_name_,"test_unit_#{index}") do |h|
                    h.input.from_up_pass            (nqq ? unit_pass_u : unit_pass_u[index])
                    h.output.logic.to_down_pass     (nqq ? unit_pass_d : unit_pass_d[index])
                end

                # TdlTestUnit.collect_unit tu_inst
                TopModule.current.test_unit.collect_unit tu_inst

                ## 添加dve wave 信号
                TopModule.current.test_unit.dve_wave(name: _inst_name_, signals: tu_inst.origin.dve_wave_signals )

                if index == 0
                    Assign do 
                        unless nqq
                            unit_pass_u[index] <= 1.b1 
                        else
                            unit_pass_u <= 1.b1 
                        end
                    end
                else 

                    Assign do 
                        unit_pass_u[index] <= unit_pass_d[last_index]
                    end
                end 
                last_index = index
                index += 1
            end
        end
    end

end