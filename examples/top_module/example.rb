require_relative '../../tdl.rb'

TopModule.test_top(__dir__) do 
    load_pins("pins.yml")
    input(pin_prop: pins['TG']['SYSCTLR_CLK']).clock(125)       - 'sys_clock'
    output(pin_prop: pins['TG']['DATA']).logic[4]               -'odata'

end