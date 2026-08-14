# 🔐 AES Encryption — RTL Hardware Implementation

A complete **AES (Advanced Encryption Standard) hardware implementation using Verilog/SystemVerilog**, featuring a modular AES encryption core, configurable key expansion, FSM-based control, and five block cipher modes of operation.

The design supports **AES-128, AES-192, and AES-256**, with dedicated verification environments for the AES core, key expansion, and all implemented encryption modes.

---

## 📌 Project Overview

This project implements the **AES encryption algorithm at the RTL hardware level**.

The design was developed using a modular architecture in which the AES encryption datapath, key expansion logic, control FSM, and state storage are implemented as separate reusable modules.

The project also extends the AES core to support multiple block cipher modes:

- ECB — Electronic Codebook
- CBC — Cipher Block Chaining
- CFB — Cipher Feedback
- OFB — Output Feedback
- CTR — Counter

The implementation supports the three standard AES key sizes:

| AES Version | Key Size | Number of Rounds |
|-------------|----------|------------------|
| AES-128 | 128 bits | 10 |
| AES-192 | 192 bits | 12 |
| AES-256 | 256 bits | 14 |

The AES data block size is **128 bits**.

---

# ✨ Key Features

- ✅ AES-128 encryption
- ✅ AES-192 encryption
- ✅ AES-256 encryption
- ✅ Configurable AES Key Expansion
- ✅ Modular AES datapath
- ✅ SubBytes
- ✅ ShiftRows
- ✅ MixColumns
- ✅ AddRoundKey
- ✅ Initial and final AES round handling
- ✅ FSM-based encryption control
- ✅ State Register
- ✅ Five encryption modes:
  - ECB
  - CBC
  - CFB
  - OFB
  - CTR
- ✅ Dedicated testbenches for AES core components
- ✅ Dedicated Key Expansion verification
- ✅ Verification across AES-128, AES-192, and AES-256
- ✅ Verification of all supported encryption modes
- ✅ ModelSim/QuestaSim simulation
- ✅ RTL linting

---

# 🏗️ Architecture

The design is divided into two main parts:

1. **AES Encryption Core**
2. **Encryption Mode Wrappers**

The AES core contains the cryptographic datapath, key expansion, state storage, and control logic.

### AES Core Architecture

```text id="j9m8x3"
                         ┌─────────────────────┐
                         │      AES TOP        │
                         └──────────┬──────────┘
                                    │
                    ┌───────────────┴───────────────┐
                    │                               │
             ┌──────▼──────┐                 ┌──────▼──────┐
             │     FSM     │                 │ Key         │
             │   Control   │                 │ Expansion   │
             └──────┬──────┘                 └──────┬──────┘
                    │                               │
                    │                        ┌──────▼──────┐
                    │                        │ Round Keys  │
                    │                        └─────────────┘
                    │
             ┌──────▼───────────────┐
             │    State Register    │
             └──────────┬───────────┘
                        │
                 ┌──────▼──────┐
                 │  AES ROUND  │
                 └──────┬──────┘
                        │
              ┌─────────┼─────────┐
              │         │         │
          SubBytes  ShiftRows  MixColumns
              │         │         │
              └─────────┼─────────┘
                        │
                 AddRoundKey
                        │
                      Output
```

---

# 🔑 AES Encryption Core

The main AES implementation is located in:

```text id="c0v3cm"
AES_Encryption/
```

The core is composed of several independent RTL modules.

### Main Modules

| Module | Function |
|--------|----------|
| `TOP.v` | Top-level AES encryption module |
| `AES_ROUND.v` | Implements an AES encryption round |
| `Initial_Round.v` | Implements the initial AddRoundKey operation |
| `SUBBYTES.sv` | AES SubBytes transformation |
| `SHIFTROWS.sv` | AES ShiftRows transformation |
| `MIXCOLUMNS.sv` | AES MixColumns transformation |
| `ADDROUNDKEY.v` | AES AddRoundKey transformation |
| `sbox.v` | AES S-Box |
| `state_register.v` | Stores the AES state between rounds |
| `fsm.v` | Controls the AES encryption sequence |
| `key_exp.v` | AES Key Expansion |
| `round_key.v` | Round-key generation and control |

---

# 🔄 AES Encryption Process

The AES encryption datapath follows the standard AES transformation sequence.

For a normal AES round:

```text id="e4y2g1"
              ┌────────────┐
State ───────►│  SubBytes  │
              └─────┬──────┘
                    │
              ┌─────▼──────┐
              │ ShiftRows  │
              └─────┬──────┘
                    │
              ┌─────▼──────┐
              │ MixColumns │
              └─────┬──────┘
                    │
              ┌─────▼──────┐
              │AddRoundKey │
              └─────┬──────┘
                    │
                  State
```

The **initial round** performs only:

```text id="1kqj0f"
AddRoundKey
```

The **final round** excludes `MixColumns`, according to the AES specification.

The control FSM determines the appropriate sequence of operations and coordinates the AES datapath with the generated round keys.

---

# 🔐 Key Expansion

The project implements AES Key Expansion for all three standard key sizes:

```text id="6f2c4d"
AES-128
AES-192
AES-256
```

The configuration is controlled through:

```text id="x2g4m1"
config.vh
```

The corresponding parameters are:

| Configuration | `Nk` | `Nr` | Key Size |
|--------------|-----:|-----:|---------:|
| AES-128 | 4 | 10 | 128 bits |
| AES-192 | 6 | 12 | 192 bits |
| AES-256 | 8 | 14 | 256 bits |

The generated round keys were verified against the AES key expansion reference examples.

### Key Expansion Verification

![alt text](<Screenshot 2026-08-14 211031.png>)
![alt text](<Screenshot 2026-08-14 211313.png>)
![alt text](<Screenshot 2026-08-14 211521.png>)


---

# 🔀 Encryption Modes

The AES core is used to implement five block cipher modes of operation:

| Mode | Full Name |
|------|-----------|
| **ECB** | Electronic Codebook |
| **CBC** | Cipher Block Chaining |
| **CFB** | Cipher Feedback |
| **OFB** | Output Feedback |
| **CTR** | Counter |

The mode-level implementations are located in:

```text id="j8z4a2"
TOP_modules_for_each_encryption_mode/
```

### Implemented Modules

```text id="h7c1s0"
AES_ECB_512.v
AES_CBC_512.v
AES_CFB_512.v
AES_OFB_512.v
AES_CTR_512.v
```

Each mode has a dedicated testbench.

---

# 🧪 Verification

Verification was performed at multiple levels, from individual AES components to the complete encryption modes.

The verification environment includes dedicated testbenches for:

- AES Key Expansion
- AES Round
- AES Top-Level
- ECB
- CBC
- CFB
- OFB
- CTR

The implemented AES core and encryption modes were tested using **AES-128, AES-192, and AES-256 configurations**.

---

# 📊 Verification Results

The following matrix summarizes the implemented verification coverage:

| Component / Mode | AES-128 | AES-192 | AES-256 |
|------------------|:-------:|:-------:|:-------:|
| Key Expansion | ✅ | ✅ | ✅ |
| AES Core | ✅ | ✅ | ✅ |
| ECB | ✅ | ✅ | ✅ |
| CBC | ✅ | ✅ | ✅ |
| CFB | ✅ | ✅ | ✅ |
| OFB | ✅ | ✅ | ✅ |
| CTR | ✅ | ✅ | ✅ |

> **Note:** Each mode-level testbench was executed for all three AES key sizes.

---

## 🔬 AES Core Verification

### AES Round

![alt text](<Screenshot 2026-08-14 213743.png>)

The AES Round testbench verifies the integration of the AES transformations:

```text id="fr7k5x"
SubBytes
    ↓
ShiftRows
    ↓
MixColumns
    ↓
AddRoundKey
```

---

### AES Top-Level

![alt text](<Screenshot 2026-08-14 214135.png>)


This testbench verifies the complete AES encryption flow and the interaction between the datapath, FSM, state register, and key expansion logic.

---

# 🔐 Encryption Mode Verification

Each supported mode was verified independently using the AES core.

### ECB

![alt text](<Screenshot 2026-08-14 214348.png>) 
![alt text](<Screenshot 2026-08-14 214231.png>) 
![alt text](<Screenshot 2026-08-14 214627.png>)
`AES_ECB_512_tb.v`

The testbench verifies ECB operation for:

- AES-128
- AES-192
- AES-256

---

### CBC

![alt text](<Screenshot 2026-08-14 214939.png>)
![alt text](<Screenshot 2026-08-14 214850.png>) 
![alt text](<Screenshot 2026-08-14 214758.png>) 
`AES_CBC_512_tb.v`

The testbench verifies CBC operation for:

- AES-128
- AES-192
- AES-256

---

### CFB

![alt text](<Screenshot 2026-08-14 215252.png>)
![alt text](<Screenshot 2026-08-14 215204.png>) 
![alt text](<Screenshot 2026-08-14 215118.png>) 
`AES_CFB_512_tb.v`

The testbench verifies CFB operation for:

- AES-128
- AES-192
- AES-256

---

### OFB

![alt text](<Screenshot 2026-08-14 215650.png>)
![alt text](<Screenshot 2026-08-14 215549.png>) 
![alt text](<Screenshot 2026-08-14 215502.png>) 
`AES_OFB_512_tb.v`

The testbench verifies OFB operation for:

- AES-128
- AES-192
- AES-256

---

### CTR

![alt text](<Screenshot 2026-08-14 215936.png>)
![alt text](<Screenshot 2026-08-14 215852.png>) 
![alt text](<Screenshot 2026-08-14 215806.png>) 
`AES_CTR_512_tb.v`

The testbench verifies CTR operation for:

- AES-128
- AES-192
- AES-256

---

# 🧩 Repository Structure

```text id="5myq8e"
-AES_Encryption/
│
├── AES_Encryption/
│   ├── ADDROUNDKEY.v
│   ├── AES_ROUND.v
│   ├── Initial_Round.v
│   ├── MIXCOLUMNS.sv
│   ├── SHIFTROWS.sv
│   ├── SUBBYTES.sv
│   ├── TOP.v
│   ├── fsm.v
│   ├── key_exp.v
│   ├── round_key.v
│   ├── sbox.v
│   └── state_register.v
│
├── TOP_modules_for_each_encryption_mode/
│   ├── AES_CBC_512.v
│   ├── AES_CFB_512.v
│   ├── AES_CTR_512.v
│   ├── AES_ECB_512.v
│   └── AES_OFB_512.v
│
├── TB_for_sub_modules/
│   ├── AES_ROUND_tb.v
│   ├── MIXCOLUMNS_tb.v
│   ├── SHIFTROWS_tb.v
│   ├── TOP_tb.v
│   ├── fsm_tb.v
│   ├── key_exp_round_key_fsm_top.v
│   ├── key_exp_round_key_fsm_top_tb.v
│   ├── key_exp_round_key_top.v
│   ├── key_exp_round_key_top_tb_128.v
│   ├── key_exp_round_key_top_tb_192.v
│   └── key_exp_round_key_top_tb_256.v
│
├── TB_for_encryption_modes/
│   ├── AES_CBC_512_tb.v
│   ├── AES_CFB_512.v
│   ├── AES_CTR_512.v
│   ├── AES_ECB_512.v
│   └── AES_OFB_512.v
│
├── LINT/
├── config.vh
├── run.do
└── README.md
```

---

# ⚙️ Configuration

The AES configuration is controlled through:

```text id="0f3k2n"
config.vh
```

The design can be configured for:

```verilog id="q9w4k1"
// AES-128
`define AES_128

// AES-192
`define AES_192

// AES-256
`define AES_256
```

Only the required AES configuration should be enabled at a time.

The configuration controls the key size and the number of AES rounds.

---

# ▶️ Simulation

The repository includes a ModelSim/QuestaSim simulation script:

```text id="5x2f9m"
run.do
```

The general simulation flow is:

```text id="n7p1q4"
Compile RTL
     ↓
Compile Testbench
     ↓
Start Simulation
     ↓
Apply Test Stimulus
     ↓
Monitor Waveforms
     ↓
Compare Actual vs Expected Results
```

Individual testbenches can also be simulated independently for module-level debugging and verification.

---

# 🔍 Verification Methodology

The verification strategy follows a hierarchical approach:

```text id="p8d3r2"
                         Verification
                              │
                ┌─────────────┴─────────────┐
                │                           │
          Unit-Level                  Integration-Level
                │                           │
        ┌───────┴────────┐          ┌───────┴────────┐
        │                │          │                │
   AES Components   Key Expansion  AES Core     Encryption Modes
        │                │          │                │
        └────────────────┴──────────┴────────────────┘
```

This methodology allows individual modules to be verified before integration into the complete AES architecture.

It also makes debugging easier by isolating errors at the component level before validating the complete encryption system.

---

# 🛠️ Tools & Technologies

### Hardware Description Languages

- Verilog
- SystemVerilog

### Design Concepts

- RTL Design
- Digital Logic Design
- Datapath Design
- Finite State Machines
- Sequential Logic
- Combinational Logic
- Cryptographic Hardware

### Verification

- RTL Testbenches
- Functional Simulation
- Waveform Analysis
- Reference-Vector Verification
- Linting

### Tools

- ModelSim / QuestaSim
- Vivado

---

# 📚 References

The implementation and verification of this project were based on the following references.

### 1. NIST — Advanced Encryption Standard

**FIPS 197 — Advanced Encryption Standard (AES)**

Used as the primary reference for:

- AES algorithm
- AES state representation
- AES transformations
- AES key sizes
- Number of rounds
- Key expansion
- Encryption procedure

---

### 2. NIST — Block Cipher Modes of Operation

**NIST SP 800-38A — Recommendation for Block Cipher Modes of Operation**

Used as a reference for:

- ECB
- CBC
- CFB
- OFB
- CTR

---

### 3. AES Key Expansion Examples

**Appendix A — Key Expansion Examples**

Used to verify the generated round keys for:

- AES-128
- AES-192
- AES-256

These examples were used as reference vectors during the implementation and verification of the key expansion logic.

---

### 4. Project Repository

The complete RTL implementation, testbenches, configuration files, linting files, and simulation scripts are available in this repository:

**[AES Encryption — GitHub Repository](https://github.com/eltaweel1/-AES_Encryption)**

---

# 🎯 Project Objectives

The main objectives of this project were to:

- Understand AES from a hardware perspective.
- Translate the AES algorithm into synthesizable RTL.
- Design a modular AES encryption datapath.
- Implement configurable AES Key Expansion.
- Support AES-128, AES-192, and AES-256.
- Design FSM-based control logic.
- Integrate the AES core into multiple encryption modes.
- Develop dedicated verification environments.
- Verify the design using reference vectors and simulation.
- Gain practical experience in cryptographic RTL design and verification.

---

# 🚀 Future Improvements

Possible future extensions include:

- AES decryption support.
- Unified encryption/decryption architecture.
- SystemVerilog Assertions (SVA).
- Functional coverage.
- Constrained-random verification.
- Formal verification.
- FPGA implementation.
- Throughput and latency analysis.
- Pipelined AES architecture.
- Hardware performance optimization.
- Additional authenticated encryption modes such as GCM.

---

# 👨‍💻 Author

**Abdelrahman Moamen Eltaweel**

Electronics & Communications Engineering Student  
Cairo University

### Areas of Interest

- RTL Design
- Digital Verification
- SystemVerilog & UVM
- FPGA
- Embedded Systems
- Hardware Security

---

## ⭐ Project

This project demonstrates a complete hardware-oriented implementation of AES, starting from the individual cryptographic transformations and key expansion, through the complete AES encryption core, and finally integrating the core into multiple block cipher modes.

The repository includes the RTL implementation, configuration files, dedicated testbenches, simulation scripts, and verification environments.

**Repository:**  
https://github.com/eltaweel1/-AES_Encryption