module alu(a, b, Cin, binv, select, result, CarOUT);
input a, b, Cin, binv;
input [1:0] select;
output reg result,CarOUT;
reg m;
reg sum;
reg cout;
always @ *
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
    result = 0;
end
endmodule


module testALUbehav();
reg a, b, carryin, binv;
reg [1:0] select;
wire result, CarOUT;

alu uut(a, b, carryin, binv, select, result, CarOUT);

initial
begin
// AND
select = 2'b00;
a = 0; b = 1; carryin = 0; binv = 0;
#5 a = 1; b = 1;

// OR
#5 select = 2'b01;
a = 0; b = 0;
#5 a = 1; b = 0;

// Addition
#5 select = 2'b10;
binv = 0; carryin = 0;
a = 0; b = 1;
#5 a = 1; b = 1;

// Subtraction 
#5 binv = 1; carryin = 1;
a = 0; b = 1;
#5 a = 1; b = 0;
// Default case
#5 select = 2'b11;
end
endmodule

