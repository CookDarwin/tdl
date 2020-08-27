## What is tdl?
&emsp;&emsp;tdl is a hardware Construction language, it like chisel, but more intresting. It is a DSL and base on ruby. Finally, it convert to systemverilog. And it depend on the axi library of my other github respo.

## What tdl can do?
&emsp;&emsp;When you write RTL code by tdl, it look like systemverilog. And not only that, you can verify design by tdl. Even more, you can construct `Logic System`, I think it is main difference between tdl and other hardware Construction languages. 

## How tdl run?
> ruby you_file.rb

#### notice: I have not public tdl to gem yet, so you must require `tdl.rb` direct. 

## Code Example
&emsp;&emsp;I write some examples in the fold ./examples

### 1. define module 
It will create a module of systemverilog that name is `test_module` in current dir.
```ruby 
TdlBuild.test_module(__dir__) do
## Other code
end
```
the sv file look like this
```systemverilog
`timescale 1ns/1ps
module test_module(
);
endmodule
```
### 2. ports
```ruby 
TdlBuild.test_module(__dir__) do 
    input.clock         - 'clock'
    input.reset('low')  - 'rst_n'
    input               - 'd0'
    input[32]           - 'd32'
    output[16]          - 'o16'
    output.logic[8]     - 'o8'
    output.logic        - 'o1'
end
```
```systemverilog
`timescale 1ns/1ps

module test_module (
    input             clock,
    input             rst_n,
    input             d0,
    input [31:0]      d32,
    output [15:0]     o16,
    output logic[7:0] o8,
    output logic      o1
);
endmodule
```

## 3. interface
```ruby 
TdlBuild.test_interface(__dir__) do 

    input.clock         - 'clock'
    input.reset('low')  - 'rst_n'
    input               - 'd0'
    input[32]           - 'd32'
    output[16]          - 'o16'
    output.logic[8]     - 'o8'
    output.logic        - 'o1'

    port.axis.slaver    - 'axis_in'
    port.axis.master    - 'axis_out'
    port.axis.mirror    - 'axis_mirror'

    port.data_c.master  - 'intf_data_inf'
    port.axi4.slaver    - 'taxi4_inf' 

end 
```
```systemverilog
`timescale 1ns/1ps

module test_module (
    input                   clock,
    input                   rst_n,
    input                   d0,
    input [31:0]            d32,
    output [15:0]           o16,
    output logic[7:0]       o8,
    output logic            o1,
    axi_stream_inf.slaver   axis_in,
    axi_stream_inf.master   axis_out,
    axi_stream_inf.mirror   axis_mirror,
    data_inf_c.master       intf_data_inf,
    axi_inf.slaver          taxi4_inf
);
end
```
## 4. always assign 
```ruby 
TdlBuild.test_module(__dir__) do 

    input.clock         - 'clock'
    input.reset('low')  - 'rst_n'
    input               - 'd0'
    input[32]           - 'd32'
    output[16]          - 'o16'
    output.logic[8]     - 'o8'
    output.logic        - 'o1'

    port.axis.slaver    - 'axis_in'
    port.axis.master    - 'axis_out'
    port.axis.mirror    - 'axis_mirror'

    port.data_c.master  - 'intf_data_inf'
    port.axi4.slaver    - 'taxi4_inf'


    always_ff(posedge: clock,negedge: rst_n) do 
        IF ~rst_n do 
            o16 <= 0.A 
        end
        ELSE do 
            IF d0 do 
                o16 <= 1.A 
            end 
            ELSE do 
                o16 <= o16 + 1.b1 
            end
        end
    end

    always_comb do 
        o8  <= d32[7,0]
    end

    Assign do 
        o1  <= 1.b0
    end
end
```
```systemverilog
`timescale 1ns/1ps

module test_module (
    input                   clock,
    input                   rst_n,
    input                   d0,
    input [31:0]            d32,
    output [15:0]           o16,
    output logic[7:0]       o8,
    output logic            o1,
    axi_stream_inf.slaver   axis_in,
    axi_stream_inf.master   axis_out,
    axi_stream_inf.mirror   axis_mirror,
    data_inf_c.master       intf_data_inf,
    axi_inf.slaver          taxi4_inf
);

always_ff@(posedge clock,negedge rst_n) begin 
    if(~rst_n)begin
         o16 <= '0;
    end
    else begin
        if(d0)begin
             o16 <= '1;
        end
        else begin
             o16 <= ( o16+1'b1);
        end
    end
end

always_comb begin 
     o8 = d32[7:0];
end

assign  o1 = 1'b0;

endmodule
```

