module aes_encrypt(
    input  [127:0] plaintext,
    input  [127:0] key,
    output [127:0] ciphertext
);

wire [1407:0] round_keys;

wire [127:0] rk0, rk1, rk2, rk3, rk4, rk5, rk6, rk7, rk8, rk9, rk10;

assign rk0  = round_keys[127:0];
assign rk1  = round_keys[255:128];
assign rk2  = round_keys[383:256];
assign rk3  = round_keys[511:384];
assign rk4  = round_keys[639:512];
assign rk5  = round_keys[767:640];
assign rk6  = round_keys[895:768];
assign rk7  = round_keys[1023:896];
assign rk8  = round_keys[1151:1024];
assign rk9  = round_keys[1279:1152];
assign rk10 = round_keys[1407:1280];

key_expansion ke (
    .key(key),
    .round_keys(round_keys)
);

wire [127:0] round0;

wire [127:0] sb1, sr1, mc1, round1;
wire [127:0] sb2, sr2, mc2, round2;
wire [127:0] sb3, sr3, mc3, round3;
wire [127:0] sb4, sr4, mc4, round4;
wire [127:0] sb5, sr5, mc5, round5;
wire [127:0] sb6, sr6, mc6, round6;
wire [127:0] sb7, sr7, mc7, round7;
wire [127:0] sb8, sr8, mc8, round8;
wire [127:0] sb9, sr9, mc9, round9;
wire [127:0] sb10, sr10;

add_round_key ark0 (.state_in(plaintext), .round_key(rk0),  .state_out(round0));

sub_bytes     r1_sb (.state_in(round0), .state_out(sb1));
shift_rows    r1_sr (.state_in(sb1),    .state_out(sr1));
mix_columns   r1_mc (.state_in(sr1),    .state_out(mc1));
add_round_key r1_ak (.state_in(mc1),    .round_key(rk1), .state_out(round1));

sub_bytes     r2_sb (.state_in(round1), .state_out(sb2));
shift_rows    r2_sr (.state_in(sb2),    .state_out(sr2));
mix_columns   r2_mc (.state_in(sr2),    .state_out(mc2));
add_round_key r2_ak (.state_in(mc2),    .round_key(rk2), .state_out(round2));

sub_bytes     r3_sb (.state_in(round2), .state_out(sb3));
shift_rows    r3_sr (.state_in(sb3),    .state_out(sr3));
mix_columns   r3_mc (.state_in(sr3),    .state_out(mc3));
add_round_key r3_ak (.state_in(mc3),    .round_key(rk3), .state_out(round3));

sub_bytes     r4_sb (.state_in(round3), .state_out(sb4));
shift_rows    r4_sr (.state_in(sb4),    .state_out(sr4));
mix_columns   r4_mc (.state_in(sr4),    .state_out(mc4));
add_round_key r4_ak (.state_in(mc4),    .round_key(rk4), .state_out(round4));

sub_bytes     r5_sb (.state_in(round4), .state_out(sb5));
shift_rows    r5_sr (.state_in(sb5),    .state_out(sr5));
mix_columns   r5_mc (.state_in(sr5),    .state_out(mc5));
add_round_key r5_ak (.state_in(mc5),    .round_key(rk5), .state_out(round5));

sub_bytes     r6_sb (.state_in(round5), .state_out(sb6));
shift_rows    r6_sr (.state_in(sb6),    .state_out(sr6));
mix_columns   r6_mc (.state_in(sr6),    .state_out(mc6));
add_round_key r6_ak (.state_in(mc6),    .round_key(rk6), .state_out(round6));

sub_bytes     r7_sb (.state_in(round6), .state_out(sb7));
shift_rows    r7_sr (.state_in(sb7),    .state_out(sr7));
mix_columns   r7_mc (.state_in(sr7),    .state_out(mc7));
add_round_key r7_ak (.state_in(mc7),    .round_key(rk7), .state_out(round7));

sub_bytes     r8_sb (.state_in(round7), .state_out(sb8));
shift_rows    r8_sr (.state_in(sb8),    .state_out(sr8));
mix_columns   r8_mc (.state_in(sr8),    .state_out(mc8));
add_round_key r8_ak (.state_in(mc8),    .round_key(rk8), .state_out(round8));

sub_bytes     r9_sb (.state_in(round8), .state_out(sb9));
shift_rows    r9_sr (.state_in(sb9),    .state_out(sr9));
mix_columns   r9_mc (.state_in(sr9),    .state_out(mc9));
add_round_key r9_ak (.state_in(mc9),    .round_key(rk9), .state_out(round9));

sub_bytes     r10_sb (.state_in(round9), .state_out(sb10));
shift_rows    r10_sr (.state_in(sb10),   .state_out(sr10));
add_round_key r10_ak (.state_in(sr10),   .round_key(rk10), .state_out(ciphertext));

endmodule