module aes_decrypt(
    input  [127:0] ciphertext,
    input  [127:0] key,
    output [127:0] plaintext
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

wire [127:0] round10;

wire [127:0] isr1, isb1, ark1, imc1;
wire [127:0] isr2, isb2, ark2, imc2;
wire [127:0] isr3, isb3, ark3, imc3;
wire [127:0] isr4, isb4, ark4, imc4;
wire [127:0] isr5, isb5, ark5, imc5;
wire [127:0] isr6, isb6, ark6, imc6;
wire [127:0] isr7, isb7, ark7, imc7;
wire [127:0] isr8, isb8, ark8, imc8;
wire [127:0] isr9, isb9, ark9, imc9;
wire [127:0] isr10, isb10;

add_round_key  start_ark (.state_in(ciphertext), .round_key(rk10), .state_out(round10));

inv_shift_rows r1_isr (.state_in(round10), .state_out(isr1));
inv_sub_bytes  r1_isb (.state_in(isr1),    .state_out(isb1));
add_round_key  r1_ark (.state_in(isb1),    .round_key(rk9), .state_out(ark1));
inv_mix_columns r1_imc(.state_in(ark1),    .state_out(imc1));

inv_shift_rows r2_isr (.state_in(imc1), .state_out(isr2));
inv_sub_bytes  r2_isb (.state_in(isr2), .state_out(isb2));
add_round_key  r2_ark (.state_in(isb2), .round_key(rk8), .state_out(ark2));
inv_mix_columns r2_imc(.state_in(ark2), .state_out(imc2));

inv_shift_rows r3_isr (.state_in(imc2), .state_out(isr3));
inv_sub_bytes  r3_isb (.state_in(isr3), .state_out(isb3));
add_round_key  r3_ark (.state_in(isb3), .round_key(rk7), .state_out(ark3));
inv_mix_columns r3_imc(.state_in(ark3), .state_out(imc3));

inv_shift_rows r4_isr (.state_in(imc3), .state_out(isr4));
inv_sub_bytes  r4_isb (.state_in(isr4), .state_out(isb4));
add_round_key  r4_ark (.state_in(isb4), .round_key(rk6), .state_out(ark4));
inv_mix_columns r4_imc(.state_in(ark4), .state_out(imc4));

inv_shift_rows r5_isr (.state_in(imc4), .state_out(isr5));
inv_sub_bytes  r5_isb (.state_in(isr5), .state_out(isb5));
add_round_key  r5_ark (.state_in(isb5), .round_key(rk5), .state_out(ark5));
inv_mix_columns r5_imc(.state_in(ark5), .state_out(imc5));

inv_shift_rows r6_isr (.state_in(imc5), .state_out(isr6));
inv_sub_bytes  r6_isb (.state_in(isr6), .state_out(isb6));
add_round_key  r6_ark (.state_in(isb6), .round_key(rk4), .state_out(ark6));
inv_mix_columns r6_imc(.state_in(ark6), .state_out(imc6));

inv_shift_rows r7_isr (.state_in(imc6), .state_out(isr7));
inv_sub_bytes  r7_isb (.state_in(isr7), .state_out(isb7));
add_round_key  r7_ark (.state_in(isb7), .round_key(rk3), .state_out(ark7));
inv_mix_columns r7_imc(.state_in(ark7), .state_out(imc7));

inv_shift_rows r8_isr (.state_in(imc7), .state_out(isr8));
inv_sub_bytes  r8_isb (.state_in(isr8), .state_out(isb8));
add_round_key  r8_ark (.state_in(isb8), .round_key(rk2), .state_out(ark8));
inv_mix_columns r8_imc(.state_in(ark8), .state_out(imc8));

inv_shift_rows r9_isr (.state_in(imc8), .state_out(isr9));
inv_sub_bytes  r9_isb (.state_in(isr9), .state_out(isb9));
add_round_key  r9_ark (.state_in(isb9), .round_key(rk1), .state_out(ark9));
inv_mix_columns r9_imc(.state_in(ark9), .state_out(imc9));

inv_shift_rows r10_isr (.state_in(imc9), .state_out(isr10));
inv_sub_bytes  r10_isb (.state_in(isr10), .state_out(isb10));
add_round_key  final_ark (.state_in(isb10), .round_key(rk0), .state_out(plaintext));

endmodule