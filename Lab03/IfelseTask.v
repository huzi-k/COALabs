module comparator(A,B,equal,greater,less);

input [1:0] A;
input [1:0] B;

output equal;
output greater;
output less;

reg equal;
reg greater;
reg less;

always @(*)
begin

    if (A == B)
    begin
        equal = 1;
        greater = 0;
        less = 0;
    end

    else if (A > B)
    begin
        equal = 0;
        greater = 1;
        less = 0;
    end

    else
    begin
        equal = 0;
        greater = 0;
        less = 1;
    end

end

endmodule

module testComp();

reg [1:0] A;
reg [1:0] B;

wire equal;
wire greater;
wire less;

comparator uut(A,B,equal,greater,less);

initial
begin

A=2'b00; B=2'b00; #50;
A=2'b00; B=2'b01; #50;
A=2'b00; B=2'b10; #50;
A=2'b00; B=2'b11; #50;

A=2'b01; B=2'b00; #50;
A=2'b01; B=2'b01; #50;
A=2'b01; B=2'b10; #50;
A=2'b01; B=2'b11; #50;

A=2'b10; B=2'b00; #50;
A=2'b10; B=2'b01; #50;
A=2'b10; B=2'b10; #50;
A=2'b10; B=2'b11; #50;

A=2'b11; B=2'b00; #50;
A=2'b11; B=2'b01; #50;
A=2'b11; B=2'b10; #50;
A=2'b11; B=2'b11; #50;

end

endmodule
