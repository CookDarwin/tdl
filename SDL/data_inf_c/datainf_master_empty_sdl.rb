
# add_to_all_file_paths('datainf_master_empty','/home/CookDarwin/work/fpga/axi/data_interface/datainf_master_empty.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/datainf_master_empty.sv'
TdlBuild.datainf_master_empty do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/datainf_master_empty.sv'
self.path = File.expand_path(__FILE__)
port.data_inf.master - 'master' 
end
