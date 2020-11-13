`timescale 1ns / 1ps

module digital_put(
input sys_clk,
input rst_n,
input [63:0] timer,
input [3:0] number1,
input [3:0] number2,
input [7:0] numbit,
output reg [7:0] ledbit,
output reg [6:0] ledshow,
output reg [6:0] ledshow2
);

function [6:0] digital;
input reg [3:0] num;
begin
    if(num == 4'd0)
    begin
        digital = 7'b1110111;//Cong Shang Dao Xia,Cong Zuo Dao You
    end
    if(num == 4'd1)
    begin
        digital = 7'b0010010;
    end
    if(num == 4'd2)
    begin
        digital = 7'b1011101;
    end
    if(num == 4'd3)
    begin
        digital = 7'b1011011;
    end
    if(num == 4'd4)
    begin
        digital = 7'b0111010;
    end
    if(num == 4'd5)
    begin
        digital = 7'b1101011;
    end
    if(num == 4'd6)
    begin
        digital = 7'b1101111;
    end
    if(num == 4'd7)
    begin
        digital = 7'b1010010;
    end
    if(num == 4'd8)
    begin
        digital = 7'b1111111;
    end
    if(num == 4'd9)
    begin
        digital = 7'b1111011;
    end
    if(num == 4'd10)
    begin
        digital = 7'b1111110;//A
    end
    if(num == 4'd11)
    begin
        digital = 7'b0100101;//L
    end
    if(num == 4'd12)
    begin
        digital = 7'b0111110;//H
    end
    if(num == 4'd13)
    begin
        digital = 7'b1100101;//C
    end
    if(num == 4'd14)
    begin
        digital = 7'b0001000;//-
    end
    if(num == 4'd15)
    begin
        digital = 7'b1101100;//F
    end
    
end
endfunction

always@*
begin
    ledbit <= numbit;
    ledshow <= digital(.num(number1));
    ledshow2 <= digital(.num(number2));
end

endmodule
