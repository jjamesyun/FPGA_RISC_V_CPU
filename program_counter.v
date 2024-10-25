module program_counter(
    input clk,
    input rst,
    input [31:0] pc_next,
    input pc_write_enable,    // For stalls
    output reg [31:0] pc_current
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc_current <= 32'h00000000;  // Reset to beginning of program
        end
        else if (pc_write_enable) begin
            pc_current <= pc_next;
        end
    end

endmodule