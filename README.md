# RISC-V CPU Implementation on DE1-SoC FPGA

This project aims to implement a RISC-V CPU on a DE1-SoC FPGA board, utilizing Verilog for hardware description. The primary objective is to design and implement a 5-stage RISC-V pipeline, operating at a frequency of 50 MHz. The pipeline consists of the following stages:

1. Instruction Fetch (IF)
2. Instruction Decode (ID)
3. Execute (EX)
4. Memory Access (MEM)
5. Write-back (WB)

## Arithmetic Logic Unit (ALU) Design and Verification

A critical component of the CPU is the Arithmetic Logic Unit (ALU), responsible for executing arithmetic and logical operations. The ALU will be designed using Verilog and thoroughly tested and simulated using ModelSim, a powerful HDL simulation tool. Adherence to the RISC-V ISA standards will be strictly maintained to ensure compatibility and correctness.

## Memory-Mapped I/O Subsystems

To enhance the functionality and flexibility of the CPU, memory-mapped I/O subsystems will be implemented. This allows for the integration of additional peripherals and enables efficient communication between the CPU and external devices.

## UART Communication with Arduino

To demonstrate the CPU's capability to interact with external devices, an Arduino will be interfaced with the DE1-SoC FPGA board using UART (Universal Asynchronous Receiver/Transmitter) communication protocol. This integration showcases the potential for expanding the system's capabilities and highlights the practical applications of the RISC-V CPU.

## Learning Outcomes and Portfolio Showcase

This project serves as a valuable learning experience, encompassing various aspects of computer architecture, digital design, and hardware description languages. By successfully implementing a RISC-V CPU on an FPGA, I aim to demonstrate my proficiency in:

- RISC-V ISA and its implementation
- Verilog hardware description language
- FPGA development using the DE1-SoC board
- ModelSim simulation and verification
- Memory-mapped I/O subsystems
- UART communication and interfacing with external devices

The project will be a significant highlight in my portfolio, showcasing my ability to design, implement, and verify complex digital systems. It demonstrates my understanding of computer architecture principles and my skills in utilizing industry-standard tools and methodologies.

I invite you to explore the code repository, where you will find detailed documentation, source code, and simulation results. Contributions, suggestions, and feedback are welcomed as I continue to enhance and refine this RISC-V CPU implementation.