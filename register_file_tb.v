module register_file_tb();
    reg clk;
    reg rst;
    reg reg_write_en;
    reg [4:0] reg_write_dest;
    reg [31:0] reg_write_data;
    reg [4:0] reg_read_addr_1;
    reg [4:0] reg_read_addr_2;
    wire [31:0] reg_read_data_1;
    wire [31:0] reg_read_data_2;

    // Instantiate register file
    register_file rf(
        .clk(clk),
        .rst(rst),
        .reg_write_en(reg_write_en),
        .reg_write_dest(reg_write_dest),
        .reg_write_data(reg_write_data),
        .reg_read_addr_1(reg_read_addr_1),
        .reg_read_data_1(reg_read_data_1),
        .reg_read_addr_2(reg_read_addr_2),
        .reg_read_data_2(reg_read_data_2)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test stimulus
    initial begin
        // Initialize
        clk = 0;
        rst = 1;
        reg_write_en = 0;
        reg_write_dest = 0;
        reg_write_data = 0;
        reg_read_addr_1 = 0;
        reg_read_addr_2 = 0;

        // Release reset
        #10 rst = 0;

        // Test 1: Write to register 1
        #10;
        reg_write_en = 1;
        reg_write_dest = 5'd1;
        reg_write_data = 32'hAABBCCDD;
        
        // Test 2: Write to register 2
        #10;
        reg_write_dest = 5'd2;
        reg_write_data = 32'h11223344;

        // Test 3: Read from registers 1 and 2
        #10;
        reg_write_en = 0;
        reg_read_addr_1 = 5'd1;
        reg_read_addr_2 = 5'd2;
        #5;
        if (reg_read_data_1 !== 32'hAABBCCDD) $display("Test 3a Failed");
        else $display("Test 3a Passed");
        if (reg_read_data_2 !== 32'h11223344) $display("Test 3b Failed");
        else $display("Test 3b Passed");

        // Test 4: Try writing to R0 (should remain 0)
        #10;
        reg_write_en = 1;
        reg_write_dest = 5'd0;
        reg_write_data = 32'hFFFFFFFF;
        #10;
        reg_read_addr_1 = 5'd0;
        if (reg_read_data_1 !== 32'h0) $display("Test 4 Failed");
        else $display("Test 4 Passed");

        $display("All tests completed");
        $finish;
    end

endmodule