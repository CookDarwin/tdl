/**********************************************
______________                ______________
______________ \  /\  /|\  /| ______________
______________  \/  \/ | \/ | ______________
descript:
author : WM
Version: VERA.0.0
created: 2020-05-22 13:53:03 +0800
madified:
***********************************************/
`timescale 1ns/1ps

module test_module(
    input               clock,
    input               clock1,
    input               rst_n,
    input               rst_n1,
    axi_inf.master_wr   axi_wr_inf
);

//==========================================================================
//-------- define ----------------------------------------------------------
logic [axi_wr_inf.ASIZE-1:0]  addr ;
logic [ axi_wr_inf.IDSIZE-4-1:0]  id ;
logic [24-1:0]  length ;
axi_inf #(.DSIZE(axi_wr_inf.DSIZE),.IDSIZE( axi_wr_inf.IDSIZE-4),.ASIZE(axi_wr_inf.ASIZE),.LSIZE(24),.MODE(ONLY_WRITE),.ADDR_STEP(8192),.FreqM(pre_axi_wr_inf.FreqM),.STSIZE(pre_axi_wr_inf.STSIZE)) pre_axi_wr_inf();
//==========================================================================
//-------- instance --------------------------------------------------------
axi_stream_cache_35bit cache_inst(
/* axi_stream_inf.slaver */.axis_in  (opop      ),
/* axi_stream_inf.master */.axis_out (" 909090" )
);
//==========================================================================
//-------- expression ------------------------------------------------------

endmodule
