module data_memory(
    input clk,
    input rst,
    // Memory access signals
    input [31:0] addr,          // Memory address
    input [31:0] write_data,    // Data to write
    input mem_write_en,         // Write enable
    input mem_read_en,          // Read enable
    // Output
    output reg [31:0] read_data // Data read from memory
);

    // Memory array (1024 words × 32 bits each)
    reg [31:0] memory [0:1023];
    
    integer i;
    
    // Reset and initialization
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Clear memory on reset
            for (i = 0; i < 1024; i = i + 1) begin
                memory[i] <= 32'b0;
            end
        end
        // Handle write operation
        else if (mem_write_en) begin
            memory[addr[11:2]] <= write_data;
        end
    end
    
    // Read operation (asynchronous read)
    always @(*) begin
        if (mem_read_en) begin
            read_data = memory[addr[11:2]];
        end
        else begin
            read_data = 32'b0;
        end
    end

endmodule