## ---- LVDS GROUP SET -------
group_path -name lvds_in_0 -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[0]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst0*" }]
set_max_delay -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[0]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst0*" }] 20
set_min_delay -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[0]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst0*" }] -10
group_path -name lvds_in_1 -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[1]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst1*" }]
set_max_delay -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[1]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst1*" }] 20
set_min_delay -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[1]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst1*" }] -10
group_path -name lvds_in_2 -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[2]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst2*" }]
set_max_delay -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[2]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst2*" }] 20
set_min_delay -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[2]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst2*" }] -10
group_path -name lvds_in_3 -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[3]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst3*" }]
set_max_delay -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[3]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst3*" }] 20
set_min_delay -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[3]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst3*" }] -10
group_path -name lvds_in_4 -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[4]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst4*" }]
set_max_delay -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[4]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst4*" }] 20
set_min_delay -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[4]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst4*" }] -10
group_path -name lvds_in_5 -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[5]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst5*" }]
set_max_delay -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[5]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst5*" }] 20
set_min_delay -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[5]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst5*" }] -10
group_path -name lvds_in_6 -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[6]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst6*" }]
set_max_delay -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[6]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst6*" }] 20
set_min_delay -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[6]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst6*" }] -10
group_path -name lvds_in_7 -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[7]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst7*" }]
set_max_delay -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[7]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst7*" }] 20
set_min_delay -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[7]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst7*" }] -10
group_path -name lvds_in_8 -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[8]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst8*" }]
set_max_delay -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[8]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst8*" }] 20
set_min_delay -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[8]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst8*" }] -10
group_path -name lvds_in_9 -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[9]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst9*" }]
set_max_delay -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[9]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst9*" }] 20
set_min_delay -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[9]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst9*" }] -10
group_path -name lvds_in_10 -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[10]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst10*" }]
set_max_delay -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[10]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst10*" }] 20
set_min_delay -from [get_ports -filter { NAME =~  "*lvds*" && DIRECTION == "IN" && NAME =~  "*[10]*" }] -to [get_pins -hierarchical -filter { NAME =~  "*sensor_lvds_rloc*" && NAME =~  "*inst10*" }] -10
## ==== LVDS GROUP SET =======
set_property BEL BFF [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_clk_inst0]
set_property LOC SLICE_X163Y194 [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_clk_inst0]
set_property BEL BFF [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_data_inst0]
set_property LOC SLICE_X163Y198 [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_data_inst0]
set_property BEL BFF [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_clk_inst1]
set_property LOC SLICE_X163Y188 [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_clk_inst1]
set_property BEL BFF [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_data_inst1]
set_property LOC SLICE_X163Y191 [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_data_inst1]
set_property BEL BFF [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_clk_inst2]
set_property LOC SLICE_X163Y181 [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_clk_inst2]
set_property BEL BFF [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_data_inst2]
set_property LOC SLICE_X163Y186 [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_data_inst2]
set_property BEL BFF [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_clk_inst3]
set_property LOC SLICE_X163Y182 [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_clk_inst3]
set_property BEL BFF [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_data_inst3]
set_property LOC SLICE_X163Y171 [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_data_inst3]
set_property BEL BFF [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_clk_inst4]
set_property LOC SLICE_X163Y170 [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_clk_inst4]
set_property BEL BFF [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_data_inst4]
set_property LOC SLICE_X163Y172 [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_data_inst4]
set_property BEL BFF [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_clk_inst5]
set_property LOC SLICE_X163Y160 [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_clk_inst5]
set_property BEL BFF [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_data_inst5]
set_property LOC SLICE_X163Y162 [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_data_inst5]
set_property BEL BFF [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_clk_inst7]
set_property LOC SLICE_X163Y140 [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_clk_inst7]
set_property BEL BFF [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_data_inst7]
set_property LOC SLICE_X163Y142 [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_data_inst7]
set_property BEL BFF [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_clk_inst8]
set_property LOC SLICE_X163Y134 [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_clk_inst8]
set_property BEL BFF [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_data_inst8]
set_property LOC SLICE_X163Y136 [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_data_inst8]
set_property BEL BFF [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_clk_inst9]
set_property LOC SLICE_X163Y128 [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_clk_inst9]
set_property BEL BFF [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_data_inst9]
set_property LOC SLICE_X163Y130 [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_data_inst9]
set_property BEL BFF [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_clk_inst10]
set_property LOC SLICE_X163Y102 [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_clk_inst10]
set_property BEL BFF [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_data_inst10]
set_property LOC SLICE_X163Y104 [get_cells -hierarchical -regexp .*sensor_lvds_rloc_inst.*FDRE_data_inst10]
