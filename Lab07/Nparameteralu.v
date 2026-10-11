module aluParameter #(parameter N = 4) (
    input [N-1:0] a,
    input [N-1:0] b,
    input [2:0] select,
    output reg [N-1:0] result
);

always @*
begin
    if (select == 3'b000)
        result = a + b;  // add
    else if (select == 3'b001)
        result = a - b;  // sub
    else if (select == 3'b010)
        result = a & b;  // and
    else if (select == 3'b011)
        result = a | b;  // or
    else if (select == 3'b100)
        result = ~a;     // not
    else if (select == 3'b101)
        result = a ^ b;  // xor
    else
        result = 0;
end

endmodule

module testNpara();
reg [3:0] a, b;
reg [2:0] select;
wire [3:0] result;

aluParameter #(4) uut(a, b, select, result);
initial
begin
a = 5; b = 3;
select = 3'b000; #10;
select = 3'b001; #10;
select = 3'b010; #10;
select = 3'b011; #10;
select = 3'b100; #10;
select = 3'b101; #10;
end
endmodule
