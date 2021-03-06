
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def _axis_to_lite_wr(
        dummy:8,
        lite:"lite",
        axis_in:"axis_in"
    )

        Tdl.add_to_all_file_paths('axis_to_lite_wr','../../axi/AXI_stream/axis_to_lite_wr.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axis_to_lite_wr','../../axi/AXI_stream/axis_to_lite_wr.sv'])
        return_stream = self
        
        lite = AxiLite.same_name_socket(:mirror,mix=true,lite,nil,belong_to_module) unless lite.is_a? String
        axis_in = AxiStream.same_name_socket(:from_up,mix=true,axis_in,nil,belong_to_module) unless axis_in.is_a? String
        
        
        


        belong_to_module.AxiStream_draw << _axis_to_lite_wr_draw(
            dummy:dummy,
            lite:lite,
            axis_in:axis_in)
        return return_stream
    end

    private

    def _axis_to_lite_wr_draw(
        dummy:8,
        lite:"lite",
        axis_in:"axis_in"
    )

        large_name_len(
            dummy,
            lite,
            axis_in
        )
        instance_name = "axis_to_lite_wr_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/axis_to_lite_wr.sv
axis_to_lite_wr#(
    .DUMMY    (#{align_signal(dummy)})
) #{instance_name}(
/*  axi_lite_inf.master_wr*/ .lite    (#{align_signal(lite,q_mark=false)}),
/*  axi_stream_inf.slaver */ .axis_in (#{align_signal(axis_in,q_mark=false)})
);
"
    end
    
    public

    def self.axis_to_lite_wr(
        dummy:8,
        lite:"lite",
        axis_in:"axis_in",
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [axis_in].first.belong_to_module unless belong_to_module
        
        
        belong_to_module.AxiStream_NC._axis_to_lite_wr(
            dummy:dummy,
            lite:lite,
            axis_in:axis_in)
        return return_stream
    end
        

end

