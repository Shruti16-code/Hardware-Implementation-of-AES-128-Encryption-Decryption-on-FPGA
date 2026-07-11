`include "aes_params_dec.v"

module top_uart_decrypt(
    input clk_osc_12mhz,
    output tx
);

wire [127:0] plaintext;

aes_decrypt uut (
    .ciphertext(`CIPHERTEXT),
    .key(`AES_KEY),
    .plaintext(plaintext)
);

reg start = 0;
reg [7:0] tx_data = 8'h00;
wire busy;

uart_tx uart0 (
    .clk(clk_osc_12mhz),
    .start(start),
    .data(tx_data),
    .tx(tx),
    .busy(busy)
);

reg [5:0] index = 0;
reg [2:0] state = 0;
reg [23:0] delay_cnt = 0;

function [7:0] to_ascii;
    input [3:0] nibble;
    begin
        if (nibble < 10)
            to_ascii = 8'h30 + nibble;
        else
            to_ascii = 8'h41 + (nibble - 10);
    end
endfunction

function [7:0] get_char;
    input [5:0] i;
    begin
        case(i)
            0:  get_char = to_ascii(plaintext[127:124]);
            1:  get_char = to_ascii(plaintext[123:120]);
            2:  get_char = to_ascii(plaintext[119:116]);
            3:  get_char = to_ascii(plaintext[115:112]);
            4:  get_char = to_ascii(plaintext[111:108]);
            5:  get_char = to_ascii(plaintext[107:104]);
            6:  get_char = to_ascii(plaintext[103:100]);
            7:  get_char = to_ascii(plaintext[99:96]);
            8:  get_char = to_ascii(plaintext[95:92]);
            9:  get_char = to_ascii(plaintext[91:88]);
            10: get_char = to_ascii(plaintext[87:84]);
            11: get_char = to_ascii(plaintext[83:80]);
            12: get_char = to_ascii(plaintext[79:76]);
            13: get_char = to_ascii(plaintext[75:72]);
            14: get_char = to_ascii(plaintext[71:68]);
            15: get_char = to_ascii(plaintext[67:64]);
            16: get_char = to_ascii(plaintext[63:60]);
            17: get_char = to_ascii(plaintext[59:56]);
            18: get_char = to_ascii(plaintext[55:52]);
            19: get_char = to_ascii(plaintext[51:48]);
            20: get_char = to_ascii(plaintext[47:44]);
            21: get_char = to_ascii(plaintext[43:40]);
            22: get_char = to_ascii(plaintext[39:36]);
            23: get_char = to_ascii(plaintext[35:32]);
            24: get_char = to_ascii(plaintext[31:28]);
            25: get_char = to_ascii(plaintext[27:24]);
            26: get_char = to_ascii(plaintext[23:20]);
            27: get_char = to_ascii(plaintext[19:16]);
            28: get_char = to_ascii(plaintext[15:12]);
            29: get_char = to_ascii(plaintext[11:8]);
            30: get_char = to_ascii(plaintext[7:4]);
            31: get_char = to_ascii(plaintext[3:0]);
            32: get_char = 8'h0D;
            33: get_char = 8'h0A;
            default: get_char = 8'h20;
        endcase
    end
endfunction

always @(posedge clk_osc_12mhz) begin
    case (state)
        0: begin
            start <= 0;
            delay_cnt <= delay_cnt + 1;
            if (delay_cnt == 24'd12000000) begin
                delay_cnt <= 0;
                index <= 0;
                state <= 1;
            end
        end

        1: begin
            if (!busy) begin
                tx_data <= get_char(index);
                start <= 1;
                state <= 2;
            end
        end

        2: begin
            start <= 0;
            state <= 3;
        end

        3: begin
            if (!busy) begin
                if (index == 33)
                    state <= 4;
                else begin
                    index <= index + 1;
                    state <= 1;
                end
            end
        end

        4: begin
            start <= 0;
            state <= 4;
        end
    endcase
end

endmodule