module alu_tb();
    // Testbench signals
    reg [31:0] a, b;
    reg [3:0] alu_control;
    wire [31:0] result;
    wire zero;

    // Instantiate the ALU
    ALU alu_inst (
        .a(a),
        .b(b),
        .alu_control(alu_control),
        .result(result),
        .zero(zero)
    );

    // Test stimulus
    initial begin
        // Initialize inputs
        a = 0;
        b = 0;
        alu_control = 0;
        
        // Wait 100 ns for global reset
        #100;
        
        // Test 1: Addition
        a = 32'h0000_000A;  // 10
        b = 32'h0000_0005;  // 5
        alu_control = 4'b0000;  // ADD
        #10;
        if (result !== 32'h0000_000F) $display("ADD Test Failed");
        else $display("ADD Test Passed: %h + %h = %h", a, b, result);
        
        // Test 2: Subtraction
        a = 32'h0000_000F;  // 15
        b = 32'h0000_0003;  // 3
        alu_control = 4'b0001;  // SUB
        #10;
        if (result !== 32'h0000_000C) $display("SUB Test Failed");
        else $display("SUB Test Passed: %h - %h = %h", a, b, result);
        
        // Test 3: AND
        a = 32'hF0F0_F0F0;
        b = 32'hFF00_FF00;
        alu_control = 4'b0010;  // AND
        #10;
        if (result !== 32'hF000_F000) $display("AND Test Failed");
        else $display("AND Test Passed: %h & %h = %h", a, b, result);
        
        // Test 4: Left Shift
        a = 32'h0000_0001;
        b = 32'h0000_0004;  // Shift by 4
        alu_control = 4'b0101;  // SLL
        #10;
        if (result !== 32'h0000_0010) $display("SLL Test Failed");
        else $display("SLL Test Passed: %h << %d = %h", a, b, result);
        
        // Test 5: Set Less Than
        a = 32'hFFFF_FFFF;  // -1 in two's complement
        b = 32'h0000_0001;  // 1
        alu_control = 4'b1000;  // SLT
        #10;
        if (result !== 32'h0000_0001) $display("SLT Test Failed");
        else $display("SLT Test Passed: %h < %h = %h", a, b, result);
        
        // Test 6: Zero flag
        a = 32'h0000_0005;
        b = 32'h0000_0005;
        alu_control = 4'b0001;  // SUB
        #10;
        if (!zero) $display("Zero Flag Test Failed");
        else $display("Zero Flag Test Passed");

        $display("All tests completed");
        $finish;
    end