/*
Author : Mahan . F . Pourkami 
An example of the modules usage 
*/


`include "sevenseg_sel.v"
`include "sevenseg_data_driver.v"


module main(input clk ,reset , input [8:0] houres , input [5:0] minute , output [4:0] seg_sel , output [7:0] seg_data);


wire [3:0] data ;

sevenseg_sel selector(.clk(clk),.reset(reset),.houres(houres),.minute(minute),.sel(seg_sel),.data(data));
sevenseg_data_driver seg_drive(.data(data),.pinout(seg_data));



endmodule

