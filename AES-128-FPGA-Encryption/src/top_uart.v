`include "aes_params.v"

module top_uart(
    input clk_osc_12mhz,
    output tx
);

wire [127:0] ciphertext;

aes_encrypt uut (
    .plaintext(`PLAINTEXT),
    .key(`AES_KEY),
    .ciphertext(ciphertext)
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
            0:  get_char = to_ascii(ciphertext[127:124]);
            1:  get_char = to_ascii(ciphertext[123:120]);
            2:  get_char = to_ascii(ciphertext[119:116]);
            3:  get_char = to_ascii(ciphertext[115:112]);
            4:  get_char = to_ascii(ciphertext[111:108]);
            5:  get_char = to_ascii(ciphertext[107:104]);
            6:  get_char = to_ascii(ciphertext[103:100]);
            7:  get_char = to_ascii(ciphertext[99:96]);
            8:  get_char = to_ascii(ciphertext[95:92]);
            9:  get_char = to_ascii(ciphertext[91:88]);
            10: get_char = to_ascii(ciphertext[87:84]);
            11: get_char = to_ascii(ciphertext[83:80]);
            12: get_char = to_ascii(ciphertext[79:76]);
            13: get_char = to_ascii(ciphertext[75:72]);
            14: get_char = to_ascii(ciphertext[71:68]);
            15: get_char = to_ascii(ciphertext[67:64]);
            16: get_char = to_ascii(ciphertext[63:60]);
            17: get_char = to_ascii(ciphertext[59:56]);
            18: get_char = to_ascii(ciphertext[55:52]);
            19: get_char = to_ascii(ciphertext[51:48]);
            20: get_char = to_ascii(ciphertext[47:44]);
            21: get_char = to_ascii(ciphertext[43:40]);
            22: get_char = to_ascii(ciphertext[39:36]);
            23: get_char = to_ascii(ciphertext[35:32]);
            24: get_char = to_ascii(ciphertext[31:28]);
            25: get_char = to_ascii(ciphertext[27:24]);
            26: get_char = to_ascii(ciphertext[23:20]);
            27: get_char = to_ascii(ciphertext[19:16]);
            28: get_char = to_ascii(ciphertext[15:12]);
            29: get_char = to_ascii(ciphertext[11:8]);
            30: get_char = to_ascii(ciphertext[7:4]);
            31: get_char = to_ascii(ciphertext[3:0]);
            32: get_char = 8'h0D; // carriage return
            33: get_char = 8'h0A; // newline
            default: get_char = 8'h20;
        endcase
    end
endfunction

always @(posedge clk_osc_12mhz) begin
    case (state)

        // Initial delay (so terminal is ready)
        0: begin
            start <= 0;
            delay_cnt <= delay_cnt + 1;
            if (delay_cnt == 24'd12000000) begin
                delay_cnt <= 0;
                index <= 0;
                state <= 1;
            end
        end

        // Load data and start transmission
        1: begin
            if (!busy) begin
                tx_data <= get_char(index);
                start <= 1;
                state <= 2;
            end
        end

        // Pulse start
        2: begin
            start <= 0;
            state <= 3;
        end

        // Wait until transmission complete
        3: begin
            if (!busy) begin
                if (index == 33)
                    state <= 4;   // STOP after one full message
                else begin
                    index <= index + 1;
                    state <= 1;
                end
            end
        end

        // STOP forever (no repetition)
        4: begin
            start <= 0;
            state <= 4;
        end

        default: state <= 4;
    endcase
end

endmodule