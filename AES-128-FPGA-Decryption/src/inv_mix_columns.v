module inv_mix_columns(
    input  [127:0] state_in,
    output [127:0] state_out
);

function [7:0] xtime;
    input [7:0] x;
    begin
        xtime = {x[6:0],1'b0} ^ (8'h1b & {8{x[7]}});
    end
endfunction

function [7:0] mul2;
    input [7:0] x;
    begin
        mul2 = xtime(x);
    end
endfunction

function [7:0] mul4;
    input [7:0] x;
    begin
        mul4 = mul2(mul2(x));
    end
endfunction

function [7:0] mul8;
    input [7:0] x;
    begin
        mul8 = mul2(mul4(x));
    end
endfunction

function [7:0] mul9;
    input [7:0] x;
    begin
        mul9 = mul8(x) ^ x;
    end
endfunction

function [7:0] mul11;
    input [7:0] x;
    begin
        mul11 = mul8(x) ^ mul2(x) ^ x;
    end
endfunction

function [7:0] mul13;
    input [7:0] x;
    begin
        mul13 = mul8(x) ^ mul4(x) ^ x;
    end
endfunction

function [7:0] mul14;
    input [7:0] x;
    begin
        mul14 = mul8(x) ^ mul4(x) ^ mul2(x);
    end
endfunction

wire [7:0] a0  = state_in[127:120];
wire [7:0] a1  = state_in[119:112];
wire [7:0] a2  = state_in[111:104];
wire [7:0] a3  = state_in[103:96];

wire [7:0] a4  = state_in[95:88];
wire [7:0] a5  = state_in[87:80];
wire [7:0] a6  = state_in[79:72];
wire [7:0] a7  = state_in[71:64];

wire [7:0] a8  = state_in[63:56];
wire [7:0] a9  = state_in[55:48];
wire [7:0] a10 = state_in[47:40];
wire [7:0] a11 = state_in[39:32];

wire [7:0] a12 = state_in[31:24];
wire [7:0] a13 = state_in[23:16];
wire [7:0] a14 = state_in[15:8];
wire [7:0] a15 = state_in[7:0];

assign state_out[127:120] = mul14(a0) ^ mul11(a1) ^ mul13(a2) ^ mul9(a3);
assign state_out[119:112] = mul9(a0)  ^ mul14(a1) ^ mul11(a2) ^ mul13(a3);
assign state_out[111:104] = mul13(a0) ^ mul9(a1)  ^ mul14(a2) ^ mul11(a3);
assign state_out[103:96]  = mul11(a0) ^ mul13(a1) ^ mul9(a2)  ^ mul14(a3);

assign state_out[95:88]   = mul14(a4) ^ mul11(a5) ^ mul13(a6) ^ mul9(a7);
assign state_out[87:80]   = mul9(a4)  ^ mul14(a5) ^ mul11(a6) ^ mul13(a7);
assign state_out[79:72]   = mul13(a4) ^ mul9(a5)  ^ mul14(a6) ^ mul11(a7);
assign state_out[71:64]   = mul11(a4) ^ mul13(a5) ^ mul9(a6)  ^ mul14(a7);

assign state_out[63:56]   = mul14(a8)  ^ mul11(a9)  ^ mul13(a10) ^ mul9(a11);
assign state_out[55:48]   = mul9(a8)   ^ mul14(a9)  ^ mul11(a10) ^ mul13(a11);
assign state_out[47:40]   = mul13(a8)  ^ mul9(a9)   ^ mul14(a10) ^ mul11(a11);
assign state_out[39:32]   = mul11(a8)  ^ mul13(a9)  ^ mul9(a10)  ^ mul14(a11);

assign state_out[31:24]   = mul14(a12) ^ mul11(a13) ^ mul13(a14) ^ mul9(a15);
assign state_out[23:16]   = mul9(a12)  ^ mul14(a13) ^ mul11(a14) ^ mul13(a15);
assign state_out[15:8]    = mul13(a12) ^ mul9(a13)  ^ mul14(a14) ^ mul11(a15);
assign state_out[7:0]     = mul11(a12) ^ mul13(a13) ^ mul9(a14)  ^ mul14(a15);

endmodule