module ha1(sum,carry,a,b);
input a;
input b;
output sum;
output carry;
assign sum = a^b;
assign carry = a & b;
endmodule

module ha2(sum,carry,a,b);
input a;
input b;
output sum;
output carry;
assign sum = a^b;
assign carry = a & b;
endmodule

module fa(SUM,COUT,a,b,cin);
input a; input b; input cin;
output SUM; output COUT;

wire s1;
wire c1;
wire c2;
ha1 half1(s1,c1,a,b);
ha2 half2(SUM,c2,s1,cin);
assign COUT = c1+c2;
endmodule

module addsub4(S,COUT,A,B,control);

input [3:0] A;
input [3:0] B;
input control;

output [3:0] S;
output COUT;

wire [3:0] BX;
wire c1;
wire c2;
wire c3;

assign BX[0] = B[0] ^ control;
assign BX[1] = B[1] ^ control;
assign BX[2] = B[2] ^ control;
assign BX[3] = B[3] ^ control;

fa FA0(S[0],c1,A[0],BX[0],control);
fa FA1(S[1],c2,A[1],BX[1],c1);
fa FA2(S[2],c3,A[2],BX[2],c2);
fa FA3(S[3],COUT,A[3],BX[3],c3);

endmodule

module testbench();

reg [3:0] A;
reg [3:0] B;
reg control;

wire [3:0] S;
wire COUT;

addsub4 uut(S,COUT,A,B,control);

initial
begin


control = 0;

A = 4'b0011;
B = 4'b0010;
#50;

A = 4'b0101;
B = 4'b0011;
#50;

A = 4'b0111;
B = 4'b0001;
#50;



control = 1;

A = 4'b0101;
B = 4'b0011;
#50;

A = 4'b1001;
B = 4'b0010;
#50;

A = 4'b0111;
B = 4'b0100;
#50;

end

endmodule
