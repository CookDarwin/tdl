/**********************************************
______________                ______________
______________ \  /\  /|\  /| ______________
______________  \/  \/ | \/ | ______________
descript:
author : WM
Version: VERA.0.0
created: 2020-08-19 19:03:51 +0800
madified:
***********************************************/
`timescale 1ns/1ps

module test_top (
    input global_sys_clk
);

//==========================================================================
//-------- define ----------------------------------------------------------
logic  clock_100M;
logic  rstn_100M;
axi_stream_inf #(.DSIZE(16)) x_origin_inf (.aclk(clock_100M),.aresetn(rstn_100M),.aclken(1'b1)) ;
//==========================================================================
//-------- instance --------------------------------------------------------
simple_clock simple_clock_inst(
/* input clock  */.sys_clk (global_sys_clk ),
/* output clock */.clock   (clock_100M     ),
/* output reset */.rst_n   (rstn_100M      )
);
a_test_md a_test_md_inst(
/* input clock           */.clock      (clock_100M   ),
/* input reset           */.rst        (~rstn_100M   ),
/* axi_stream_inf.master */.origin_inf (x_origin_inf )
);
//==========================================================================
//-------- expression ------------------------------------------------------
assign  x_origin_inf.axis_tvalid = 1'b0;
assign  x_origin_inf.axis_tdata = '0;
assign  x_origin_inf.axis_tlast = 1'b0;

endmodule
