/**********************************************
______________                ______________
______________ \  /\  /|\  /| ______________
______________  \/  \/ | \/ | ______________
descript:
author : WM
Version: VERA.0.0
created: 2020-08-19 15:56:21 +0800
madified:
***********************************************/
`timescale 1ns/1ps

module main_md (
    input         clock,
    input         rst_n,
    output [11:0] oDdata
);

//==========================================================================
//-------- define ----------------------------------------------------------

axi_stream_inf #(.DSIZE(8)) tmp_inf (.aclk(clock),.aresetn(rst_n),.aclken(1'b1)) ;
//==========================================================================
//-------- instance --------------------------------------------------------
sdl_md sdl_md_inst(
/* input clock           */.clock   (clock   ),
/* input reset           */.rst_n   (rst_n   ),
/* output                */.odata   (        ),
/* axi_stream_inf.slaver */.asi_inf (tmp_inf )
);
hdl_md #(
    .DSIZE (12 )
)hdl_md_inst(
/* input                 */.clock   (clock  ),
/* input                 */.rst_n   (rst_n  ),
/* output                */.odata   (oDdata ),
/* axi_stream_inf.master */.in_axis (       )
);
//==========================================================================
//-------- expression ------------------------------------------------------

endmodule
