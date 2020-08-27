/**********************************************
______________                ______________
______________ \  /\  /|\  /| ______________
______________  \/  \/ | \/ | ______________
descript:
author : WM
Version: VERA.0.0
created: 2020-08-19 09:52:18 +0800
madified:
***********************************************/
`timescale 1ns/1ps

module exmple_md #(
    parameter  DSIZE  = 8,
    parameter real MK = 1.1
)(
    input                    insdata,
    output                   outsdata,
    input [7:0]              inpdata,
    output [15:0]            outpdata,
    output logic[ DSIZE-1:0] ldata,
    input                    clock,
    input                    rst_n
);

//==========================================================================
//-------- define ----------------------------------------------------------


//==========================================================================
//-------- instance --------------------------------------------------------

//==========================================================================
//-------- expression ------------------------------------------------------
assign  outsdata = insdata;

always_comb begin 
     outpdata[8:0] = inpdata;
end

always_ff@(posedge clock,negedge rst_n) begin 
    if(~rst_n)begin
         ldata <= '0;
    end
    else begin
         ldata[ DSIZE-1:0] <= ( outpdata[7:0]+insdata);
    end
end

endmodule
