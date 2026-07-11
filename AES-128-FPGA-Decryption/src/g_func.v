module g_func(
    input  [31:0] word_in,
    input  [7:0]  rcon,
    output [31:0] word_out
);

wire [31:0] rot;
wire [7:0] s0, s1, s2, s3;

assign rot = {word_in[23:0], word_in[31:24]};

sbox sb0 (.in(rot[31:24]), .out(s0));
sbox sb1 (.in(rot[23:16]), .out(s1));
sbox sb2 (.in(rot[15:8]),  .out(s2));
sbox sb3 (.in(rot[7:0]),   .out(s3));

assign word_out = {s0 ^ rcon, s1, s2, s3};

endmodule