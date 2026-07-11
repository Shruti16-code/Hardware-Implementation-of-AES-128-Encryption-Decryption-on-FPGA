# Hardware Implementation of AES-128 Encryption/Decryption on FPGA

A complete hardware implementation of the AES-128 (Advanced Encryption Standard) algorithm with both encryption and decryption capabilities, designed and implemented in Verilog for FPGA deployment.

## Overview

This repository contains a full-featured AES-128 cryptographic system implemented in hardware description language (Verilog). The implementation includes:

- **AES-128 Encryption Engine**: Complete 128-bit encryption pipeline
- **AES-128 Decryption Engine**: Complete 128-bit decryption pipeline
- **UART Interface**: Communication interface for real-time data transmission
- **Key Expansion**: Dynamic key scheduling for round keys
- **Comprehensive Testbenches**: Verification modules for both encryption and decryption

## Project Structure

```
Hardware-Implementation-of-AES-128-Encryption-Decryption-on-FPGA/
├── AES-128-FPGA-Encryption/          # Encryption Implementation
│   ├── src/                          # Source files
│   │   ├── aes_encrypt.v             # Main AES encryption module
│   │   ├── top_uart.v                # Top-level module with UART interface
│   │   ├── key_expansion.v           # Key schedule generation
│   │   ├── sbox.v                    # Substitution box lookup table
│   │   ├── sub_bytes.v               # SubBytes transformation
│   │   ├── shift_rows.v              # ShiftRows transformation
│   │   ├── mix_columns.v             # MixColumns transformation
│   │   ├── add_round_key.v           # AddRoundKey operation
│   │   └── g_func.v                  # Key expansion utility function
│   ├── testbench/                    # Test modules
│   │   └── aes_params.v              # AES parameters/constants
│   └── constraints/                  # FPGA constraints
│       └── aes.ucf                   # User constraints file
│
├── AES-128-FPGA-Decryption/          # Decryption Implementation
│   ├── src/                          # Source files
│   │   ├── aes_decrypt.v             # Main AES decryption module
│   │   ├── top_uart_decrypt.v        # Top-level module with UART interface
│   │   ├── key_expansion.v           # Key schedule generation
│   │   ├── sbox.v                    # Substitution box lookup table
│   │   ├── inv_sbox.v                # Inverse substitution box lookup table
│   │   ├── inv_sub_bytes.v           # Inverse SubBytes transformation
│   │   ├── inv_shift_rows.v          # Inverse ShiftRows transformation
│   │   ├── inv_mix_columns.v         # Inverse MixColumns transformation
│   │   ├── add_round_key.v           # AddRoundKey operation
│   │   ├── g_func.v                  # Key expansion utility function
│   │   └── inv-subytes.v             # Alternative inverse SubBytes implementation
│   ├── testbench/                    # Test modules
│   │   └── aes_params_dec.v          # AES parameters/constants for decryption
│   └── constraints/                  # FPGA constraints
│       └── dec.ucf                   # User constraints file
│
└── README.md                         # This file
```

## AES-128 Architecture

### Encryption Process
The encryption implementation follows the standard AES-128 algorithm:

1. **Key Expansion**: Generates 11 round keys from the original 128-bit key
2. **AddRoundKey**: XORs plaintext with the initial round key
3. **10 Encryption Rounds** (9 full rounds + 1 final round):
   - **SubBytes**: Substitution operation using S-box lookup
   - **ShiftRows**: Permutation of bytes in state matrix
   - **MixColumns**: Linear transformation on state matrix (skipped in final round)
   - **AddRoundKey**: XOR with round key
4. **Output**: 128-bit ciphertext

### Decryption Process
The decryption implementation uses the Inverse Cipher algorithm:

1. **Key Expansion**: Generates 11 round keys from the original 128-bit key
2. **AddRoundKey**: XORs ciphertext with the final round key
3. **10 Decryption Rounds** (9 full rounds + 1 final round):
   - **InvShiftRows**: Inverse permutation of bytes in state matrix
   - **InvSubBytes**: Inverse substitution operation using inverse S-box
   - **AddRoundKey**: XOR with round key
   - **InvMixColumns**: Inverse linear transformation on state matrix (skipped in final round)
4. **Output**: 128-bit plaintext

## Key Modules

### Encryption Modules

| Module | Purpose |
|--------|---------|
| `aes_encrypt.v` | Core AES-128 encryption pipeline with round operations |
| `top_uart.v` | Top-level wrapper integrating AES encryption with UART I/O |
| `key_expansion.v` | Generates round keys from input 128-bit key |
| `sbox.v` | S-box lookup table used in SubBytes transformation |
| `sub_bytes.v` | Applies SubBytes transformation to state |
| `shift_rows.v` | Performs ShiftRows operation on state matrix |
| `mix_columns.v` | Performs MixColumns linear transformation |
| `add_round_key.v` | XORs state with round key |
| `g_func.v` | Helper function for key expansion algorithm |

### Decryption Modules

| Module | Purpose |
|--------|---------|
| `aes_decrypt.v` | Core AES-128 decryption pipeline with inverse round operations |
| `top_uart_decrypt.v` | Top-level wrapper integrating AES decryption with UART I/O |
| `key_expansion.v` | Generates round keys from input 128-bit key |
| `sbox.v` | S-box lookup table used in key expansion |
| `inv_sbox.v` | Inverse S-box lookup table for InvSubBytes transformation |
| `inv_sub_bytes.v` | Applies InvSubBytes transformation to state |
| `inv_shift_rows.v` | Performs InvShiftRows operation on state matrix |
| `inv_mix_columns.v` | Performs InvMixColumns inverse linear transformation |
| `add_round_key.v` | XORs state with round key |
| `g_func.v` | Helper function for key expansion algorithm |

## Specifications

- **Algorithm**: AES-128 (Advanced Encryption Standard with 128-bit keys)
- **Key Size**: 128 bits
- **Block Size**: 128 bits
- **Number of Rounds**: 10
- **Implementation Language**: Verilog
- **Supported Platforms**: Xilinx FPGA (verified with provided constraints files)
- **Interface**: UART for serial communication

## Features

✅ Full AES-128 Encryption Support  
✅ Full AES-128 Decryption Support  
✅ UART Serial Interface for I/O  
✅ Key Expansion for Round Keys  
✅ Optimized S-box Implementations  
✅ FPGA Board Constraints Files  
✅ Modular Architecture for easy integration  

## Usage

### Prerequisites
- Xilinx ISE/Vivado or compatible Verilog synthesis tool
- FPGA development board (Spartan or similar)
- UART communication interface

### Implementation Steps

1. **For Encryption**:
   - Add all files from `AES-128-FPGA-Encryption/src/` to your project
   - Use `top_uart.v` as the top-level module
   - Apply constraints from `AES-128-FPGA-Encryption/constraints/aes.ucf`
   - Synthesize, implement, and generate bitstream

2. **For Decryption**:
   - Add all files from `AES-128-FPGA-Decryption/src/` to your project
   - Use `top_uart_decrypt.v` as the top-level module
   - Apply constraints from `AES-128-FPGA-Decryption/constraints/dec.ucf`
   - Synthesize, implement, and generate bitstream

3. **Testing**:
   - Use testbench files to verify functionality
   - Load bitstream onto FPGA
   - Use UART terminal to send plaintext/ciphertext and verify output

## Communication Protocol

The UART interface allows real-time encryption/decryption:
- **Baud Rate**: As defined in UART module (typically 9600 or 115200)
- **Data Format**: 128-bit blocks
- **Key Input**: 128-bit key (can be reconfigured)
- **Output**: Encrypted/decrypted 128-bit results

## Synthesis and Implementation

The modules are fully synthesizable and have been designed for:
- Low latency operation
- Efficient resource utilization on FPGA
- Pipelined architecture support
- Xilinx FPGA family compatibility

## File Statistics

- **Language**: 100% Verilog
- **Total Modules**: 19 (10 encryption + 9 decryption related)
- **Key Components**: S-boxes, Key expansion, Round transformations
- **Interface Types**: UART, cryptographic operations

## Applications

This implementation is suitable for:
- Secure IoT device communication
- Real-time data encryption on embedded systems
- Hardware-accelerated cryptographic operations
- Educational cryptography studies
- Secure FPGA applications

## Standards Compliance

- **AES Specification**: FIPS 197 (Federal Information Processing Standards)
- **Algorithm**: Rijndael (128-bit block, 128-bit key variant)

## Notes

- Shared modules (`sbox.v`, `g_func.v`, `key_expansion.v`, `add_round_key.v`) are used in both encryption and decryption pipelines
- The implementation prioritizes correctness and modularity over optimization
- Testbenches (`aes_params.v`, `aes_params_dec.v`) contain parameters and constants for verification

## License

This project is provided as-is for educational and research purposes.

## Support

For questions or issues regarding the implementation, please refer to the AES standard documentation (FIPS 197) or relevant Verilog HDL references.

---

**Last Updated**: 2026  
**Language**: Verilog (100%)  
**Repository**: Hardware-Implementation-of-AES-128-Encryption-Decryption-on-FPGA
