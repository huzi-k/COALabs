
module alu1bit(a, b, Cin, binv, less, select, result, CarOUT);

input a, b, Cin, binv, less;
input [1:0] select;
output reg result, CarOUT;

reg m;
reg sum;
reg cout;

always @*
begin
    m = b ^ binv;
    {cout, sum} = a + m + Cin;
    CarOUT = 0;

    if (select == 2'b00)
        result = a & b;
    else if (select == 2'b01)
        result = a | b;
    else if (select == 2'b10) begin
        result = sum;
        CarOUT = cout;
    end
    else
        result = less;
end

endmodule


module alu4bit(a, b, op, result, CF, SF, ZF, OF);

input [3:0] a, b;
input [2:0] op;
output reg [3:0] result;
output reg CF, SF, ZF, OF;

wire binv;
wire [4:0] carry;
wire [3:0] tempresult;
wire lessbit;
wire overflow;
wire [3:0] subresult;
wire [4:0] subcarry;
wire suboverflow;
reg [1:0] select;

always @*
begin
    if (op == 3'b000)
        select = 2'b00;
    else if (op == 3'b001)
        select = 2'b01;
    else if (op == 3'b111)
        select = 2'b11;
    else
        select = 2'b10;
end

assign binv = (op == 3'b110 || op == 3'b111);
assign carry[0] = binv;

alu1bit bit0(a[0], b[0], carry[0], binv, lessbit,
             select, tempresult[0], carry[1]);

alu1bit bit1(a[1], b[1], carry[1], binv, 1'b0,
             select, tempresult[1], carry[2]);

alu1bit bit2(a[2], b[2], carry[2], binv, 1'b0,
             select, tempresult[2], carry[3]);

alu1bit bit3(a[3], b[3], carry[3], binv, 1'b0,
             select, tempresult[3], carry[4]);

// Independent subtraction for signed SLT
assign subcarry[0] = 1'b1;
assign subcarry[1] = a[0] ^ b[0] ? a[0] : subcarry[0];
assign subresult = a - b;
assign suboverflow = (a[3] ^ b[3]) & (a[3] ^ subresult[3]);
assign lessbit = subresult[3] ^ suboverflow;

assign overflow = carry[3] ^ carry[4];

always @*
begin
    result = tempresult;
    CF = 0;
    SF = result[3];
    ZF = (result == 4'b0000);
    OF = 0;

    if (op == 3'b010 || op == 3'b110)
    begin
        CF = carry[4];
        OF = overflow;
    end
end

endmodule


module test4bitALU();

reg [3:0] a, b;
reg [2:0] op;
wire [3:0] result;
wire CF, SF, ZF, OF;

alu4bit uut(a, b, op, result, CF, SF, ZF, OF);

initial
begin
    a = 5; b = 3; op = 3'b000; // and
    #10 a = 5; b = 3; op = 3'b001; // or
    #10 a = 5; b = 3; op = 3'b010; // add
    #10 a = 5; b = 3; op = 3'b110; // sub
    #10 a = 3; b = 5; op = 3'b111; // SLT
end
endmodule

