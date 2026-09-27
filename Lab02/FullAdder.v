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

module testbench();
reg a;
reg b;
reg cin;
wire SUM;
wire COUT;

fa uut(SUM,COUT,a,b,cin);

initial
begin
a=0; b=0; cin=0;
#50 a=0; b=0; cin=1;
#50 a=0; b=1; cin=0;
#50 a=0; b=1; cin=1;	
#50 a=1; b=0; cin=0;
#50 a=1; b=0; cin=1;
#50 a=1; b=1; cin=0;
#50 a=1; b=1; cin=1;
end
endmodule
 




