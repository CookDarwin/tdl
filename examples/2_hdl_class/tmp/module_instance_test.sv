/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
created: 2020-05-22 15:33:18 +0800
madified:
***********************************************/
`timescale 1ns/1ps

module module_instance_test();
//==========================================================================
//-------- define ----------------------------------------------------------


//==========================================================================
//-------- instance --------------------------------------------------------
test_struct_function #(
    .NUM (8 )
)test_struct_function_inst(
/* input  */.ain       (ain       ),
/* output */.bout      (bout      ),
/* input  */.in_array  (in_array  ),
/* output */.out_array (out_array )
);
//==========================================================================
//-------- expression ------------------------------------------------------

endmodule