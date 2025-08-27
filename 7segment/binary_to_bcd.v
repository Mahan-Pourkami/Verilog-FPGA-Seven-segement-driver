/* Author : Mahan . F . Pourkami 
/* Date : 28/08/2025
/*this module was defined to convert the binary values to bcd digits , 
cause of the spartan3  FPGA Boards only support % and / for the powers of 2 */

module binary_to_bcd(

    input [8:0] binary,

    output reg [3:0] hundreds,

    output reg [3:0] tens,

    output reg [3:0] ones

);

    integer i;

    reg [11:0] bcd; 

    

    always @(*) begin

        bcd = 0;

        for (i = 0; i < 9; i = i+1) begin



            bcd = {bcd[10:0], binary[8-i]};

            if (i < 8) begin

                if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;

                if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;

                if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;

            end

        end

        hundreds = bcd[11:8];

        tens = bcd[7:4];

        ones = bcd[3:0];

    end

endmodule