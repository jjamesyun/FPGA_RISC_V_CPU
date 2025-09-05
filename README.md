# RISC-V CPU Implementation on DE1-SoC FPGA

This project implements a **5-stage RISC-V pipeline CPU** on a DE1-SoC FPGA using Verilog. The design supports the **RV32I base instruction set**, running at 50 MHz on the target board. The project emphasizes fundamental computer architecture principles, modular Verilog design, and thorough testbench verification.  

---

## Features

- **5-Stage Pipeline**: Instruction Fetch (IF), Instruction Decode (ID), Execute (EX), Memory Access (MEM), Write-Back (WB)  
- **Instruction Set**: Supports a subset of RV32I instructions  
- **Modular Design**: Each major CPU component is implemented as an individual Verilog module for clarity and reusability  
- **Verification**: Comprehensive testbenches developed for critical modules (ALU, Control Unit, Register File, Data Memory) using ModelSim  

---

## Pipeline Overview

IF  –>  ID  –>  EX  –>  MEM  –>  WB
|        |       |       |       |
|        |       |       |       └─ Writes results back to Register File
|        |       |       └─ Reads/Writes Data Memory
|        |       └─ ALU executes arithmetic/logic ops
|        └─ Control Unit generates control signals
└─ Program Counter fetches next instruction

---

## Module Hierarchy

RISC-V CPU
│
├── program_counter.v       # Tracks instruction flow
├── control_unit.v          # Decodes instructions, generates control signals
├── alu.v                   # Arithmetic and logic operations
│   └── alu_testbench.v
├── register_file.v         # 32 general-purpose registers (2R/1W ports)
│   └── register_file_testbench.v
├── data_memory.v           # Read/write data memory
│   └── data_memory_tb.v
└── control_unit_testbench.v

---

## Tools & Workflow
- **Verilog HDL** for hardware description  
- **ModelSim** for functional simulation and verification  
- **Quartus Prime** for FPGA synthesis and implementation on DE1-SoC  

---

## Learning Outcomes
Through this project, I gained hands-on experience with:  

- Pipelined CPU design following the RISC-V ISA  
- Writing and debugging Verilog for hardware modules  
- Developing **testbenches** to achieve functional correctness  
- FPGA synthesis and hardware implementation workflows  

---

## Future Work
- Extend support for additional RISC-V instructions  
- Implement pipeline hazard detection and forwarding  
- Add memory-mapped I/O peripherals  
- Explore UART or other interfaces for external device communication  

---

## Repository
This repository contains:  

- Source code for all CPU modules  
- Testbenches for functional verification  
- Documentation of the architecture and implementation details  
