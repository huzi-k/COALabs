module decode (y0,y1,y2,y3,y4,y5,y6,y7,a,b,c);
input a,b,c;
output y0,y1,y2,y3,y4,y5,y6,y7;

wire nota,notb,notc;

not(nota,a);
not(notb,b);
not(notc,c);

and(y0,nota,notb,notc);
and(y1,nota,notb,c);
and(y2,nota,b,notc);
and(y3,nota,b,c);
and(y4,a,notb,notc);
and(y5,a,notb,c);
and(y6,a,b,notc);
and(y7,a,b,c);
endmodule

module testbenchDecode();
reg a,b,c;
wire y0,y1,y2,y3,y4,y5,y6,y7;

decode uut(y0,y1,y2,y3,y4,y5,y6,y7,a,b,c);

initial
begin
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