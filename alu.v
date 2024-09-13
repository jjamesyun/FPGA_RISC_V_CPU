module alu(
    input [31:0] a, b
    input [3:0] op_code,
    output reg [31:0] result,
    output zero
);

    localparam  ALU_ADD = 4'b0000,
                ALU_SUB = 4'b0001,
                ALU_AND = 4'b0010,
                ALU_OR  = 4'b0011,
                ALU_XOR = 4'b0100,
                ALU_SLL = 4'b0101, // Shift left logical
                ALU_SRL = 4'b0110, // Shift right logical
                ALU_SRA = 4'b0111, // Shift right arithmetic
                ALU_SLT = 4'b1000; // Set less than

    assign zero = (result == 32'b0);

    always @(*) begin
        case (op_code)
            ALU_ADD: result = a + b;
            ALU_SUB: result = a - b;
            ALU_AND: result = a & b;
            ALU_OR:  result = a | b;
            ALU_XOR: result = a ^ b;
            ALU_SLL: result = a << b[4:0]; // Use only bottom 5 bits for shift
            ALU_SRL: result = a >> b[4:0];
            ALU_SRA: result = $signed(a) >>> b[4:0];
            ALU_SLT: result = ($signed(a) < $signed(b)) ? 32'b1 : 32'b0;
            default: result = 32'b0;
        endcase
    end

endmodule