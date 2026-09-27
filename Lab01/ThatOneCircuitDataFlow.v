module AndGate(A,B,andout);
input A;
input B;
output andout;
and a1(andout,A,B);
endmodule

module OrGate(A,B,orout);
input A;
input B;
output orout;
or a1(orout,A,B);
endmodule

module NotGate(A,notout);
input A;
output notout;
not a1(notout,A);
endmodule

module testbenchTask4GATELEVEL();
reg A,B;
wire ANDx,ANDy,OR,ANOT,BNOT;
NotGate anot (A,ANOT);
NotGate bnot (B,BNOT);
AndGate aNOTb(ANOT,B,ANDx);
AndGate AbNOT (A,BNOT,ANDy);
OrGate ORresult (ANDx,ANDy,OR);

initial 
 
begin 
A=0; B=0; 
#50 A=0; B=1; 
#50 A=1; B=0; 
#50 A=1; B=1; 
end 
endmodule 


