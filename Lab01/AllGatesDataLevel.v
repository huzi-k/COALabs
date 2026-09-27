module AndGate(A,B,andout);
input A;
input B;
output andout;
assign andout=A&B;
endmodule

module OrGate(A,B,orout);
input A;
input B;
output orout;
assign orout=A+B;
endmodule

module NotGate(A,notout);
input A;
output notout;
assign notout=~A;
endmodule

module testbenchdataflow();
reg A,B;
wire AND,OR,NOT;
AndGate uut(A,B,AND);
OrGate uup (A,B,OR);
NotGate abc (A,NOT);
initial 
 
begin 
A=0; B=0; 
#50 A=0; B=1; 
#50 A=1; B=0; 
#50 A=1; B=1; 
end 
endmodule 