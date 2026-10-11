module alugateflow(a, b, carryin, binv, select, result, carryout);

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

xor (m, b, binv);
xor (x1, a, m);
xor (sum, x1, carryin);

and (c1, a, m);
and (c2, x1, carryin);
or (cout, c1, c2);

and (andoutput, a, b);
or (oroutput, a, b);

wire n1, n0;
not (n1, select[1]);
not (n0, select[0]);

and (andselect, n1, n0);
and (orselect, n1, select[0]);
and (operatorselect, select[1], n0);

wire r1, r2, r3;

and (r1, andselect, andoutput);
and (r2, orselect, oroutput);
and (r3, operatorselect, sum);

or (result, r1, r2, r3);
and (carryout, operatorselect, cout);

endmodule

module testaluGate();
reg a, b, carryin, binv;
reg [1:0] select;
wire result, CarOUT;

alugateflow uut(a, b, carryin, binv, select, result, CarOUT);

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