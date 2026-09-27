module multiplex(Y,A,B,Select);

input A,B,Select;
output Y;

wire notSelect;
wire w0,w1;
wire andAB;
wire orAB;

not(notSelect,Select);

and(andAB,A,B);
or(orAB,A,B);

and(w0,andAB,notSelect);
and(w1,orAB,Select);

or(Y,w0,w1);

endmodule

module testMult();

reg A,B,Select;
wire Y;

multiplex uut(Y,A,B,Select);

initial
begin

Select = 0; A = 0; B = 0;
#50 Select = 0; A = 0; B = 1;
#50 Select = 0; A = 1; B = 0;
#50 Select = 0; A = 1; B = 1;

#50 Select = 1; A = 0; B = 0;
#50 Select = 1; A = 0; B = 1;
#50 Select = 1; A = 1; B = 0;
#50 Select = 1; A = 1; B = 1;

end

endmodule
