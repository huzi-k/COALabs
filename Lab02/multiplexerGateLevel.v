module multiplex(y0,y1,y2,y3,y4,y5,y6,y7,a,b,c,z);
input a,b,c,y0,y1,y2,y3,y4,y5,y6,y7;
output z;
wire nota,notb,notc;
not(nota,a);
not(notb,b);
not(notc,c);

wire w0,w1,w2,w3,w4,w5,w6,w7;

and(w0,y0,nota,notb,notc);
and(w1,y1,nota,notb,c);
and(w2,y2,nota,b,notc);
and(w3,y3,nota,b,c);
and(w4,y4,a,notb,notc);
and(w5,y5,a,notb,c);
and(w6,y6,a,b,notc);
and(w7,y7,a,b,c);
or(z,w0,w1,w2,w3,w4,w5,w6,w7);

endmodule

module testMult();
reg a,b,c,y0,y1,y2,y3,y4,y5,y6,y7;
wire z;
multiplex uut(y0,y1,y2,y3,y4,y5,y6,y7,a,b,c,z);
initial
begin
y0 = 0;
y1 = 0;
y2 = 1;
y3 = 1;
y4 = 0;
y5 = 0;
y6 = 1;
y7 = 0;
a = 0; b = 0; c = 0;
#50 a = 0; b = 0; c = 1;
#50 a = 0; b = 1; c = 0;
#50 a = 0; b = 1; c = 1;
#50 a = 1; b = 0; c = 0;
#50 a = 1; b = 0; c = 1;
#50 a = 1; b = 1; c = 0;
#50 a = 1; b = 1; c = 1;
end
endmodule

