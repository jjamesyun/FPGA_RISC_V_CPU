module data_memory_tb();
    reg clk;
    reg rst;
    reg [31:0] addr;
    reg [31:0] write_data;
    reg mem_write_en;
    reg mem_read_en;
    wire [31:0] read_data;

    // Instantiate data memory
    data_memory dm (
        .clk(clk),
        .rst(rst),
        .addr(addr),
        .write_data(write_data),
        .mem_write_en(mem_write_en),
        .mem_read_en(mem_read_en),
        .read_data(read_data)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test stimulus
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        addr = 0;
        write_data = 0;
        mem_write_en = 0;
        mem_read_en = 0;

        // Release reset
        #10 rst = 0;

        // Test 1: Write to memory
        #10;
        addr = 32'h4;
        write_data = 32'hAABBCCDD;
        mem_write_en = 1;
        #10;
        mem_write_en = 0;

        // Test 2: Read from memory
        #10;
        addr = 32'h4;
        mem_read_en = 1;
        #5;
        if (read_data !== 32'hAABBCCDD)
            $display("Test 2 Failed: Read data mismatch");
        else
            $display("Test 2 Passed: Read data matches written data");

        // Test 3: Write to different location
        #10;
        addr = 32'h8;
        write_data = 32'h11223344;
        mem_write_en = 1;
        mem_read_en = 0;
        #10;
        mem_write_en = 0;

        // Test 4: Read from both locations
        addr = 32'h4;
        mem_read_en = 1;
        #5;
        if (read_data !== 32'hAABBCCDD)
            $display("Test 4a Failed: First location data corrupted");
        else
            $display("Test 4a Passed: First location data intact");

        #5;
        addr = 32'h8;
        #5;
        if (read_data !== 32'h11223344)
            $display("Test 4b Failed: Second location read error");
        else
            $display("Test 4b Passed: Second location read correct");

        $display("All tests completed");
        $finish;
    end

endmodule