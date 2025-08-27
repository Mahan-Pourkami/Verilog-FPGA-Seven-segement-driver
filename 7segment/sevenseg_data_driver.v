module sevenseg_data_driver(

    input [3:0] data,

    output reg [7:0] pinout

);

    always @(*) begin

        case(data)

            4'b0000: pinout <= 8'b00111111; // 0

            4'b0001: pinout <= 8'b00000110; // 1

            4'b0010: pinout <= 8'b01011011; // 2

            4'b0011: pinout <= 8'b01001111; // 3

            4'b0100: pinout <= 8'b01100110; // 4

            4'b0101: pinout <= 8'b01101101; // 5

            4'b0110: pinout <= 8'b01111101; // 6

            4'b0111: pinout <= 8'b00000111; // 7

            4'b1000: pinout <= 8'b01111111; // 8

            4'b1001: pinout <= 8'b01101111; // 9

            default: pinout <= 8'b00000000; // off

        endcase

    end

endmodule
