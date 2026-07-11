module mix_columns(
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

function [7:0] mul3;
    input [7:0] x;
    begin
        mul3 = xtime(x) ^ x;
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

assign state_out[127:120] = mul2(a0)  ^ mul3(a1)  ^ a2       ^ a3;
assign state_out[119:112] = a0        ^ mul2(a1)  ^ mul3(a2) ^ a3;
assign state_out[111:104] = a0        ^ a1        ^ mul2(a2) ^ mul3(a3);
assign state_out[103:96]  = mul3(a0)  ^ a1        ^ a2       ^ mul2(a3);

assign state_out[95:88]   = mul2(a4)  ^ mul3(a5)  ^ a6       ^ a7;
assign state_out[87:80]   = a4        ^ mul2(a5)  ^ mul3(a6) ^ a7;
assign state_out[79:72]   = a4        ^ a5        ^ mul2(a6) ^ mul3(a7);
assign state_out[71:64]   = mul3(a4)  ^ a5        ^ a6       ^ mul2(a7);

assign state_out[63:56]   = mul2(a8)  ^ mul3(a9)  ^ a10      ^ a11;
assign state_out[55:48]   = a8        ^ mul2(a9)  ^ mul3(a10)^ a11;
assign state_out[47:40]   = a8        ^ a9        ^ mul2(a10)^ mul3(a11);
assign state_out[39:32]   = mul3(a8)  ^ a9        ^ a10      ^ mul2(a11);

assign state_out[31:24]   = mul2(a12) ^ mul3(a13) ^ a14      ^ a15;
assign state_out[23:16]   = a12       ^ mul2(a13) ^ mul3(a14)^ a15;
assign state_out[15:8]    = a12       ^ a13       ^ mul2(a14)^ mul3(a15);
assign state_out[7:0]     = mul3(a12) ^ a13       ^ a14      ^ mul2(a15);

endmodule