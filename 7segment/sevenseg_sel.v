`include "binary_to_bcd.v"

module sevenseg_sel(

    input clk,

    input reset,

    input [8:0] houres,

    input [5:0] minute,

    output reg [4:0] sel = 5'b00001,

    output reg [3:0] data

);

    reg [18:0] counter = 0;

    wire clk_enable = (counter == 80000 - 1);

    

    wire [3:0] minute_ones, minute_tens;

    binary_to_bcd minute_bcd(

        .binary({3'b0, minute}),

        .hundreds(),

        .tens(minute_tens),

        .ones(minute_ones)

    );

    

    wire [3:0] houres_ones, houres_tens;

    binary_to_bcd append_bcd(

        .binary(houres
),

        .hundreds(),

        .tens(houres_tens),

        .ones(houres_ones
        )

    );

    

    always @(posedge clk ) begin
	 
	         if(~reset) begin 
				
				sel<=5'b01000 ;
				data <= 7 ; 
				
				end 
	 

           else if (clk_enable) begin

                counter <= 0;

                case(sel)

                    5'b00001: begin

                        sel <= 5'b00010;

                        data <= minute_tens;

                    end
						  

                    5'b00010: begin

                        sel <= 5'b00100;

                        data <= houres_ones
                        ;

                    end
						  

                    5'b00100: begin

                        sel <= 5'b01000;

                        data <= houres_tens;

                    end
						  

                    5'b01000: begin

                        sel <= 5'b00001;

                        data <= minute_ones;

                    end
						  

                    default: begin

                        sel <= 5'b00001;

                        data <= 0;

                    end

                endcase

            end else begin

                counter <= counter + 1;

            end

           end

endmodule
