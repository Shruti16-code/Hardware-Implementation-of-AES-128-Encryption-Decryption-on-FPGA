module key_expansion(
    input  [127:0] key,
    output [1407:0] round_keys
);

wire [31:0] w0,  w1,  w2,  w3;
wire [31:0] w4,  w5,  w6,  w7;
wire [31:0] w8,  w9,  w10, w11;
wire [31:0] w12, w13, w14, w15;
wire [31:0] w16, w17, w18, w19;
wire [31:0] w20, w21, w22, w23;
wire [31:0] w24, w25, w26, w27;
wire [31:0] w28, w29, w30, w31;
wire [31:0] w32, w33, w34, w35;
wire [31:0] w36, w37, w38, w39;
wire [31:0] w40, w41, w42, w43;

wire [31:0] g3, g7, g11, g15, g19, g23, g27, g31, g35, g39;

assign w0 = key[127:96];
assign w1 = key[95:64];
assign w2 = key[63:32];
assign w3 = key[31:0];

g_func u1  (.word_in(w3),  .rcon(8'h01), .word_out(g3));
assign w4  = w0 ^ g3;
assign w5  = w1 ^ w4;
assign w6  = w2 ^ w5;
assign w7  = w3 ^ w6;

g_func u2  (.word_in(w7),  .rcon(8'h02), .word_out(g7));
assign w8  = w4 ^ g7;
assign w9  = w5 ^ w8;
assign w10 = w6 ^ w9;
assign w11 = w7 ^ w10;

g_func u3  (.word_in(w11), .rcon(8'h04), .word_out(g11));
assign w12 = w8 ^ g11;
assign w13 = w9 ^ w12;
assign w14 = w10 ^ w13;
assign w15 = w11 ^ w14;

g_func u4  (.word_in(w15), .rcon(8'h08), .word_out(g15));
assign w16 = w12 ^ g15;
assign w17 = w13 ^ w16;
assign w18 = w14 ^ w17;
assign w19 = w15 ^ w18;

g_func u5  (.word_in(w19), .rcon(8'h10), .word_out(g19));
assign w20 = w16 ^ g19;
assign w21 = w17 ^ w20;
assign w22 = w18 ^ w21;
assign w23 = w19 ^ w22;

g_func u6  (.word_in(w23), .rcon(8'h20), .word_out(g23));
assign w24 = w20 ^ g23;
assign w25 = w21 ^ w24;
assign w26 = w22 ^ w25;
assign w27 = w23 ^ w26;

g_func u7  (.word_in(w27), .rcon(8'h40), .word_out(g27));
assign w28 = w24 ^ g27;
assign w29 = w25 ^ w28;
assign w30 = w26 ^ w29;
assign w31 = w27 ^ w30;

g_func u8  (.word_in(w31), .rcon(8'h80), .word_out(g31));
assign w32 = w28 ^ g31;
assign w33 = w29 ^ w32;
assign w34 = w30 ^ w33;
assign w35 = w31 ^ w34;

g_func u9  (.word_in(w35), .rcon(8'h1b), .word_out(g35));
assign w36 = w32 ^ g35;
assign w37 = w33 ^ w36;
assign w38 = w34 ^ w37;
assign w39 = w35 ^ w38;

g_func u10 (.word_in(w39), .rcon(8'h36), .word_out(g39));
assign w40 = w36 ^ g39;
assign w41 = w37 ^ w40;
assign w42 = w38 ^ w41;
assign w43 = w39 ^ w42;

assign round_keys[127:0]      = {w0,  w1,  w2,  w3};
assign round_keys[255:128]    = {w4,  w5,  w6,  w7};
assign round_keys[383:256]    = {w8,  w9,  w10, w11};
assign round_keys[511:384]    = {w12, w13, w14, w15};
assign round_keys[639:512]    = {w16, w17, w18, w19};
assign round_keys[767:640]    = {w20, w21, w22, w23};
assign round_keys[895:768]    = {w24, w25, w26, w27};
assign round_keys[1023:896]   = {w28, w29, w30, w31};
assign round_keys[1151:1024]  = {w32, w33, w34, w35};
assign round_keys[1279:1152]  = {w36, w37, w38, w39};
assign round_keys[1407:1280]  = {w40, w41, w42, w43};

endmodule