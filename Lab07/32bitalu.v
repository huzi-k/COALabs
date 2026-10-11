module alu32(
    input [31:0] a,
    input [31:0] b,
    input [3:0] alu_op,
    output reg [31:0] result,
    output zero
);

always @*
begin
    if (alu_op == 4'b0000)
        result = a + b;                  // add
    else if (alu_op == 4'b0001)
        result = a - b;                  // sub
    else if (alu_op == 4'b0010)
        result = a & b;                  // and
    else if (alu_op == 4'b0011)
        result = a | b;                  // or
    else if (alu_op == 4'b0100)
        result = a ^ b;                  // xor
    else if (alu_op == 4'b0101)
        result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0; // SLT
    else if (alu_op == 4'b0110)
        result = (a < b) ? 32'd1 : 32'd0; // sltu
    else if (alu_op == 4'b0111)
        result = a << b[4:0];            // sll
    else if (alu_op == 4'b1000)
        result = a >> b[4:0];            // srl
    else if (alu_op == 4'b1001)
        result = $signed(a) >>> b[4:0];  // sra
    else
        result = 32'd0;
end

assign zero = (result == 32'd0);

endmodule


module test32bit();

reg [31:0] a, b;
reg [3:0] alu_op;
wire [31:0] result;
wire zero;

alu32 uut(a, b, alu_op, result, zero);

initial
begin
    //1 + 2 = 3
    a = 32'd1; b = 32'd2; alu_op = 4'b0000;
    #10;

    //1 - 2 = -1
    a = 32'd1; b = 32'd2; alu_op = 4'b0001;
    #10;

    //1 & 2 = 0
    a = 32'd1; b = 32'd2; alu_op = 4'b0010;
    #10;

    //1 | 2 = 3
    a = 32'd1; b = 32'd2; alu_op = 4'b0011;
    #10;

    //1 ^ 2 = 3
    a = 32'd1; b = 32'd2; alu_op = 4'b0100;
    #10;

    // SLT 1 < 2 = 1
    a = 32'd1; b = 32'd2; alu_op = 4'b0101;
    #10;

    // SLTU 1 < 2 = 1
    a = 32'd1; b = 32'd2; alu_op = 4'b0110;
    #10;

    // SLL 1 << 2 = 4
    a = 32'd1; b = 32'd2; alu_op = 4'b0111;
    #10;

    // SRL 1 >> 2 = 0
    a = 32'd1; b = 32'd2; alu_op = 4'b1000;
    #10;

    // SRA 1 >>> 2 = 0
    a = 32'd1; b = 32'd2; alu_op = 4'b1001;
    #10;

end
endmodule


