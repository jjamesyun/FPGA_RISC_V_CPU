module control_unit(
    input [6:0] opcode,            // Instruction opcode
    input [2:0] funct3,            // Function code
    input [6:0] funct7,            // Function code for R-type
    
    // Output control signals
    output reg [3:0] alu_control,  // ALU operation
    output reg reg_write_en,       // Register write enable
    output reg mem_write_en,       // Memory write enable
    output reg mem_read_en,        // Memory read enable
    output reg [1:0] result_src,   // 00: ALU, 01: Memory, 10: PC+4
    output reg alu_src,            // 0: Register, 1: Immediate
    output reg pc_src,             // 0: PC+4, 1: Branch/Jump target
    output reg branch              // Branch instruction
);

    // RISC-V Opcodes
    localparam R_TYPE    = 7'b0110011;
    localparam I_TYPE    = 7'b0010011;
    localparam LOAD      = 7'b0000011;
    localparam STORE     = 7'b0100011;
    localparam BRANCH    = 7'b1100011;
    localparam JAL       = 7'b1101111;
    localparam JALR      = 7'b1100111;

    // ALU Operations (matching our ALU)
    localparam ALU_ADD = 4'b0000;
    localparam ALU_SUB = 4'b0001;
    localparam ALU_AND = 4'b0010;
    localparam ALU_OR  = 4'b0011;
    localparam ALU_XOR = 4'b0100;
    localparam ALU_SLL = 4'b0101;
    localparam ALU_SRL = 4'b0110;
    localparam ALU_SRA = 4'b0111;
    localparam ALU_SLT = 4'b1000;

    always @(*) begin
        // Default values
        alu_control = ALU_ADD;
        reg_write_en = 1'b0;
        mem_write_en = 1'b0;
        mem_read_en = 1'b0;
        result_src = 2'b00;
        alu_src = 1'b0;
        pc_src = 1'b0;
        branch = 1'b0;

        case(opcode)
            R_TYPE: begin
                reg_write_en = 1'b1;
                case({funct7, funct3})
                    10'b0000000000: alu_control = ALU_ADD;  // ADD
                    10'b0100000000: alu_control = ALU_SUB;  // SUB
                    10'b0000000111: alu_control = ALU_AND;  // AND
                    10'b0000000110: alu_control = ALU_OR;   // OR
                    10'b0000000100: alu_control = ALU_XOR;  // XOR
                    10'b0000000001: alu_control = ALU_SLL;  // SLL
                    10'b0000000101: alu_control = ALU_SRL;  // SRL
                    10'b0100000101: alu_control = ALU_SRA;  // SRA
                    10'b0000000010: alu_control = ALU_SLT;  // SLT
                endcase
            end

            I_TYPE: begin
                reg_write_en = 1'b1;
                alu_src = 1'b1;
                case(funct3)
                    3'b000: alu_control = ALU_ADD;  // ADDI
                    3'b111: alu_control = ALU_AND;  // ANDI
                    3'b110: alu_control = ALU_OR;   // ORI
                    3'b100: alu_control = ALU_XOR;  // XORI
                    3'b010: alu_control = ALU_SLT;  // SLTI
                endcase
            end

            LOAD: begin
                reg_write_en = 1'b1;
                mem_read_en = 1'b1;
                alu_src = 1'b1;
                result_src = 2'b01;
            end

            STORE: begin
                mem_write_en = 1'b1;
                alu_src = 1'b1;
            end

            BRANCH: begin
                branch = 1'b1;
                alu_control = ALU_SUB;
            end

            JAL: begin
                reg_write_en = 1'b1;
                pc_src = 1'b1;
                result_src = 2'b10;
            end

            JALR: begin
                reg_write_en = 1'b1;
                pc_src = 1'b1;
                result_src = 2'b10;
                alu_src = 1'b1;
            end

        endcase
    end

endmodule