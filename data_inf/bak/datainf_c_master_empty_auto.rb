
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class DataInf_C


    def datainf_c_master_empty(master:"master",down_stream:nil)

        Tdl.add_to_all_file_paths(['datainf_c_master_empty','../../axi/data_interface/datainf_c_master_empty.sv'])
        return_stream = self
        
        master = DataInf_C.same_name_socket(:to_down,mix=true,master) unless master.is_a? String
        
        
        master = self unless self==DataInf_C.NC

         @instance_draw_stack << lambda { datainf_c_master_empty_draw(master:master,down_stream:down_stream) }
        return return_stream
    end

    def datainf_c_master_empty_draw(master:"master",down_stream:nil)

        large_name_len(master)
"
// FilePath:::../../axi/data_interface/datainf_c_master_empty.sv
datainf_c_master_empty datainf_c_master_empty_#{signal}_inst(
/*  data_inf_c.master*/ .master (#{align_signal(master,q_mark=false)})
);
"
    end
    
    def self.datainf_c_master_empty(master:"master",down_stream:nil)
        return_stream = nil
        
        
        
        if down_stream.is_a? DataInf_C
            down_stream.datainf_c_master_empty(master:master,down_stream:down_stream)
        elsif master.is_a? DataInf_C
            master.datainf_c_master_empty(master:master,down_stream:down_stream)
        else
            DataInf_C.NC.datainf_c_master_empty(master:master,down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_datainf_c_master_empty
        c0 = Clock.new(name:"datainf_c_master_empty_clk",freqM:148.5)
        r0 = Reset.new(name:"datainf_c_master_empty_rst_n",active:"low")

        master = DataInf_C.new(name:"master",clock:c0,reset:r0)
        
        down_stream = master
        DataInf_C.datainf_c_master_empty(master:master)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_datainf_c_master_empty(
        master:"master")
        hash = TdlHash.new
        
        unless master.is_a? Hash
            hash.case_record(:master,master)
        else
            # hash.new_index(:master)= lambda { a = DataInf_C.new(master);a.name = "master";return a }
            # hash[:master] = lambda { a = DataInf_C.new(master);a.name = "master";return a }
            raise TdlError.new('datainf_c_master_empty DataInf_C master TdlHash cant include Proc') if master.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = DataInf_C.new(master)
                unless master[:name]
                    a.name = "master"
                end
                return a }
            hash.[]=(:master,lam,false)
        end
                

        hash.push_to_module_stack(DataInf_C,:datainf_c_master_empty)
        hash.open_error = true
        return hash
    end
end
