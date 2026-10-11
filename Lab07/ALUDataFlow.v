module aludataflow(a, b, carryin, binv, select, result, carryout);
input a, b;
input carryin, binv;
input [1:0] select;
output result;
output carryout;
wire m;
wire x1, sum;
wire c1, c2, cout;

wire andoutput, oroutput;
wire andselect, orselect, operatorselect;
assign m = b ^ binv;
assign x1 = a ^ m;
assign sum = x1 ^ carryin;
assign c1 = a & m;
assign c2 = x1 & carryin;
assign cout = c1 | c2;
assign andoutput = a & b;
assign oroutput = a | b;
assign andselect = ~select[1] & ~select[0];
assign orselect = ~select[1] & select[0];
assign operatorselect = select[1] & ~select[0];
assign result = (andselect & andoutput) |
(orselect & oroutput) |
(operatorselect & sum);
assign carryout = operatorselect & cout;
endmodule


module testaluDataFlow();
reg a, b, carryin, binv;
reg [1:0] select;
wire result, CarOUT;

aludataflow uut(a, b, carryin, binv, select, result, CarOUT);

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
