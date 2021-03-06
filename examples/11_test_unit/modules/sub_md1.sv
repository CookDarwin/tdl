/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
created: xxxx.xx.xx
madified:
***********************************************/
`timescale 1ns/1ps

module sub_md1 (
    axi_stream_inf.master   axis_out,
    output logic            enable
);

//==========================================================================
//-------- define ----------------------------------------------------------
logic  clock;
logic  rst_n;
logic [10-1:0]  cnt ;
data_inf_c #(.DSIZE(8)) inter_tf (.clock(clock),.rst_n(rst_n)) ;
//==========================================================================
//-------- instance --------------------------------------------------------

//==========================================================================
//-------- expression ------------------------------------------------------
assign  clock = axis_out.aclk;
assign  rst_n = axis_out.aresetn;

always_ff@(posedge clock,negedge rst_n) begin 
    if(~rst_n)begin
         cnt <= '0;
    end
    else begin
         cnt <= ( cnt+1'b1);
    end
end

endmodule
