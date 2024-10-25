module register_file(
    input clk,
    input rst,
    // Write port
    input reg_write_en,
    input [4:0] reg_write_dest,
    input [31:0] reg_write_data,
    // Read port 1
    input [4:0] reg_read_addr_1,
    output [31:0] reg_read_data_1,
    // Read port 2
    input [4:0] reg_read_addr_2,
    output [31:0] reg_read_data_2
);

    reg [31:0] registers [0:31];
    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset all registers to 0
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end
        else if (reg_write_en && reg_write_dest != 5'b0) begin
            registers[reg_write_dest] <= reg_write_data;
        end
    end

    // R0 is hardwired to 0
    assign reg_read_data_1 = (reg_read_addr_1 == 5'b0) ? 32'b0 : registers[reg_read_addr_1];
    assign reg_read_data_2 = (reg_read_addr_2 == 5'b0) ? 32'b0 : registers[reg_read_addr_2];

endmodule