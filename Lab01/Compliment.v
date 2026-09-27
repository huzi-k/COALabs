module compliment(A,Aout);

input [3:0] A;
output [3:0] Aout;

assign Aout[0] = ~A[0];
assign Aout[1] = ~A[1];
assign Aout[2] = ~A[2];
assign Aout[3] = ~A[3];

endmodule


module testbenchtask6DATAFLOWLEVEL();

reg [3:0] A;
wire [3:0] Aout;

compliment G1(A,Aout);

initial
begin
    A = 4'b0000;
    #50 A = 4'b1001;
    #50 A = 4'b1011;
    #50 A = 4'b1111;
end

endmodule
