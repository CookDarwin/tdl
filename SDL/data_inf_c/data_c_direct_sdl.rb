
# add_to_all_file_paths('data_c_direct','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_direct.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_direct.sv'
TdlBuild.data_c_direct do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_direct.sv'
self.path = File.expand_path(__FILE__)
port.data_inf_c.slaver - 'slaver' 
port.data_inf_c.master - 'master' 
end
