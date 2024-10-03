module control_unit_tb();
    // Inputs
    reg [6:0] opcode;
    reg [2:0] funct3;
    reg [6:0] funct7;
    
    // Outputs
    wire [3:0] alu_control;
    wire reg_write_en;
    wire mem_write_en;
    wire mem_read_en;
    wire [1:0] result_src;
    wire alu_src;
    wire pc_src;
    wire branch;
    
    // Instantiate Control Unit
    control_unit dut (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .alu_control(alu_control),
        .reg_write_en(reg_write_en),
        .mem_write_en(mem_write_en),
        .mem_read_en(mem_read_en),
        .result_src(result_src),
        .alu_src(alu_src),
        .pc_src(pc_src),
        .branch(branch)
    );
    
    // Task to display test results
    task display_test;
        input [200:0] test_name;
        begin
            $display("\nTest: %s", test_name);
            $display("alu_control = %b", alu_control);
            $display("reg_write_en = %b", reg_write_en);
            $display("mem_write_en = %b", mem_write_en);
            $display("mem_read_en = %b", mem_read_en);
            $display("result_src = %b", result_src);
            $display("alu_src = %b", alu_src);
            $display("pc_src = %b", pc_src);
            $display("branch = %b", branch);
        end
    endtask
    
    // Test stimulus
    initial begin
        // Initialize inputs
        opcode = 0;
        funct3 = 0;
        funct7 = 0;
        
        // Test Case 1: R-type ADD instruction
        #10;
        opcode = 7'b0110011;  // R-type
        funct3 = 3'b000;      // ADD
        funct7 = 7'b0000000;
        display_test("R-type ADD");
        
        // Test Case 2: R-type SUB instruction
        #10;
        opcode = 7'b0110011;  // R-type
        funct3 = 3'b000;      // SUB
        funct7 = 7'b0100000;
        display_test("R-type SUB");
        
        // Test Case 3: I-type ADDI instruction
        #10;
        opcode = 7'b0010011;  // I-type
        funct3 = 3'b000;      // ADDI
        funct7 = 7'b0000000;
        display_test("I-type ADDI");
        
        // Test Case 4: Load instruction
        #10;
        opcode = 7'b0000011;  // LOAD
        funct3 = 3'b010;      // LW
        funct7 = 7'b0000000;
        display_test("LOAD (LW)");
        
        // Test Case 5: Store instruction
        #10;
        opcode = 7'b0100011;  // STORE
        funct3 = 3'b010;      // SW
        funct7 = 7'b0000000;
        display_test("STORE (SW)");
        
        // Test Case 6: Branch instruction (BEQ)
        #10;
        opcode = 7'b1100011;  // BRANCH
        funct3 = 3'b000;      // BEQ
        funct7 = 7'b0000000;
        display_test("BRANCH (BEQ)");
        
        // Test Case 7: JAL instruction
        #10;
        opcode = 7'b1101111;  // JAL
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        display_test("JAL");
        
        // Test Case 8: JALR instruction
        #10;
        opcode = 7'b1100111;  // JALR
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        display_test("JALR");
        
        // Test verification
        #10;
        $display("\nTestbench completed");
        $finish;
    end
    
    // Optional: Monitor changes
    initial begin
        $monitor("Time=%0t opcode=%b funct3=%b funct7=%b", 
                 $time, opcode, funct3, funct7);
    end

endmodule