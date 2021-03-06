
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def axis_width_combin_a1(
        slim_axis:"slim_axis",
        wide_axis:"wide_axis",
        up_stream:nil,
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('axis_width_combin_a1','../../axi/AXI_stream/data_width/axis_width_combin_A1.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axis_width_combin_a1','../../axi/AXI_stream/data_width/axis_width_combin_A1.sv'])
        return_stream = self
        
        slim_axis = AxiStream.same_name_socket(:from_up,mix=true,slim_axis,nil,belong_to_module) unless slim_axis.is_a? String
        wide_axis = AxiStream.same_name_socket(:to_down,mix=true,wide_axis,nil,belong_to_module) unless wide_axis.is_a? String
        
        if up_stream.nil? && slim_axis.eql?("slim_axis") && (!(wide_axis.eql?("wide_axis")) || !down_stream.nil?)
            # up_stream = self.copy(name:"slim_axis")
            # return_stream = up_stream
            wide_axis = down_stream if down_stream
            return down_stream.axis_width_combin_a1(slim_axis:self)
        end

        slim_axis = up_stream if up_stream
        unless self.eql? belong_to_module.AxiStream_NC
            wide_axis = self
        else
            if down_stream
                wide_axis = down_stream
            end
        end


        belong_to_module.AxiStream_draw << axis_width_combin_a1_draw(
            slim_axis:slim_axis,
            wide_axis:wide_axis,
            up_stream:up_stream,
            down_stream:down_stream)
        return return_stream
    end

    private

    def axis_width_combin_a1_draw(
        slim_axis:"slim_axis",
        wide_axis:"wide_axis",
        up_stream:nil,
        down_stream:nil
    )

        large_name_len(
            slim_axis,
            wide_axis
        )
        instance_name = "axis_width_combin_A1_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/data_width/axis_width_combin_A1.sv
axis_width_combin_A1 #{instance_name}(
/*  axi_stream_inf.slaver*/ .slim_axis (#{align_signal(slim_axis,q_mark=false)}),
/*  axi_stream_inf.master*/ .wide_axis (#{align_signal(wide_axis,q_mark=false)})
);
"
    end
    
    public

    def self.axis_width_combin_a1(
        slim_axis:"slim_axis",
        wide_axis:"wide_axis",
        up_stream:nil,
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [slim_axis,wide_axis].first.belong_to_module unless belong_to_module
        
        if down_stream.nil? && wide_axis.eql?("wide_axis")
            if up_stream.is_a? AxiStream
                down_stream = up_stream.copy
            else
                down_stream = slim_axis.copy
            end
            return_stream = down_stream
        end

        
        if up_stream.nil? && slim_axis.eql?("slim_axis")
            if down_stream.is_a? AxiStream
                up_stream = down_stream.copy
            else
                up_stream = wide_axis.copy
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? AxiStream
            down_stream.axis_width_combin_a1(
                slim_axis:slim_axis,
                wide_axis:wide_axis,
                up_stream:up_stream,
                down_stream:down_stream)
        elsif wide_axis.is_a? AxiStream
            wide_axis.axis_width_combin_a1(
                slim_axis:slim_axis,
                wide_axis:wide_axis,
                up_stream:up_stream,
                down_stream:down_stream)
        else
            belong_to_module.AxiStream_NC.axis_width_combin_a1(
                slim_axis:slim_axis,
                wide_axis:wide_axis,
                up_stream:up_stream,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

