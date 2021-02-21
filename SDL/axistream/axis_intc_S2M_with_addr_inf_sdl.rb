
# add_to_all_file_paths('axis_intc_S2M_with_addr_inf','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_intc_S2M_with_addr_inf.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_intc_S2M_with_addr_inf.sv'
TdlBuild.axis_intc_S2M_with_addr_inf do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_intc_S2M_with_addr_inf.sv'
self.path = File.expand_path(__FILE__)
parameter.NUM   8
parameter.USE_PIPE   "OFF"
port.axi_stream_inf.slaver - 's00' 
port.axi_stream_inf.master[ param.NUM] - 'm00' 
port.data_inf_c.slaver - 'addr_inf' 
end
