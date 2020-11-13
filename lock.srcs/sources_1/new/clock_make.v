`timescale 1ns / 1ps

module clock_make(
input sys_clk,
input rst_n,
input [7:0] is_jmp,
input left_button,
input right_button,
input up_button,
input down_button,
input middle_button,
input lock_status,
input read_status,
input load_status,
output reg [63:0] led_timer,
output reg [63:0] pwd_cng_timer,
output reg [63:0] jmp1,
output reg [63:0] jmp2,
output reg [63:0] jmp3,
output reg [63:0] jmp4,
output reg [63:0] jmp5,
output reg [63:0] jmp6,
output reg [63:0] jmp7,
output reg [63:0] jmp8,
output reg [63:0] timer,
output reg [63:0] main_timer,
output reg [63:0] right_timer,
output reg [63:0] left_timer,
output reg [63:0] up_timer,
output reg [63:0] down_timer,
output reg [63:0] middle_timer
);

always@(posedge sys_clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        pwd_cng_timer <= 64'd0;
    end
    else
    begin
        if(pwd_cng_timer == 64'd99_999_999)pwd_cng_timer <= 0;
        else 
        begin
            if(middle_button)
            begin
                pwd_cng_timer <= pwd_cng_timer + 1'b1;
            end
            else
            begin
                pwd_cng_timer <= 0;
            end
        end
    end
end

always@(posedge sys_clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        left_timer <= 64'd0;
    end
    else
    begin
        if(left_timer == 64'd9_999_999)left_timer <= 0;
        else 
        begin
            if(left_button)
            begin
                left_timer <= left_timer + 1'b1;
            end
            else
            begin
                left_timer <= 0;
            end
        end
    end
end

always@(posedge sys_clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        right_timer <= 64'd0;
    end
    else
    begin
        if(right_timer == 64'd9_999_999)right_timer <= 0;
        else 
        begin
            if(right_button)
            begin
                right_timer <= right_timer + 1'b1;
            end
            else
            begin
                right_timer <= 0;
            end
        end
    end
end

always@(posedge sys_clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        up_timer <= 64'd0;
    end
    else
    begin
        if(up_timer == 64'd9_999_999)up_timer <= 0;
        else 
        begin
            if(up_button)
            begin
                up_timer <= up_timer + 1'b1;
            end
            else
            begin
                up_timer <= 0;
            end
        end
    end
end

always@(posedge sys_clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        down_timer <= 64'd0;
    end
    else
    begin
        if(down_timer == 64'd9_999_999)down_timer <= 0;
        else 
        begin
            if(down_button)
            begin
                down_timer <= down_timer + 1'b1;
            end
            else
            begin
                down_timer <= 0;
            end
        end
    end
end

always@(posedge sys_clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        middle_timer <= 64'd0;
    end
    else
    begin
        if(middle_timer == 64'd9_999_999)middle_timer <= 0;
        else 
        begin
            if(middle_button)
            begin
                middle_timer <= middle_timer + 1'b1;
            end
            else
            begin
                middle_timer <= 0;
            end
        end
    end
end

always@(posedge sys_clk or negedge rst_n)
begin
    if(~rst_n)led_timer <= 64'd0;
    else if(read_status == 1'b0)led_timer <= 64'd0;
    else if(led_timer == 64'd1_799_999_999)led_timer <= 64'd0;
    else led_timer <= led_timer + 1'b1;
end

always@(posedge sys_clk or negedge rst_n)
begin
    if(~rst_n)timer <= 64'd0;
    else if(timer == 64'd1_249_999)timer <= 64'd0;
    else timer <= timer + 1'b1;
end

always@(posedge sys_clk or negedge rst_n)
begin
    if(~rst_n)main_timer <= 64'd0;
    else main_timer <= main_timer + 1'b1;
end

always@(posedge sys_clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        jmp1 <= 1'b0;
        jmp2 <= 1'b0;
        jmp3 <= 1'b0;
        jmp4 <= 1'b0;
        jmp5 <= 1'b0;
        jmp6 <= 1'b0;
        jmp7 <= 1'b0;
        jmp8 <= 1'b0;
    end
    else
    begin
        if(is_jmp[0] == 1'b1)
        begin
            jmp8 = jmp8 + 1'b1;
        end
        if(is_jmp[1] == 1'b1)
        begin
            jmp7 = jmp7 + 1'b1;
        end
        if(is_jmp[2] == 1'b1)
        begin
            jmp6 = jmp6 + 1'b1;
        end
        if(is_jmp[3] == 1'b1)
        begin
            jmp5 = jmp5 + 1'b1;
        end
        if(is_jmp[4] == 1'b1)
        begin
            jmp4 = jmp4 + 1'b1;
        end
        if(is_jmp[5] == 1'b1)
        begin
            jmp3 = jmp3 + 1'b1;
        end
        if(is_jmp[6] == 1'b1)
        begin
            jmp2 = jmp2 + 1'b1;
        end
        if(is_jmp[7] == 1'b1)
        begin
            jmp1 = jmp1 + 1'b1;
        end
        if(jmp1 >= 100000000)
        begin
            jmp1 = jmp1 % 100000000;
        end
        if(jmp2 >= 100000000)
        begin
            jmp2 = jmp2 % 100000000;
        end
        if(jmp3 >= 100000000)
        begin
            jmp3 = jmp3 % 100000000;
        end
        if(jmp4 >= 100000000)
        begin
            jmp4 = jmp4 % 100000000;
        end
        if(jmp5 >= 100000000)
        begin
            jmp5 = jmp5 % 100000000;
        end
        if(jmp6 >= 100000000)
        begin
            jmp6 = jmp6 % 100000000;
        end
        if(jmp7 >= 100000000)
        begin
            jmp7 = jmp7 % 100000000;
        end
        if(jmp8 >= 100000000)
        begin
            jmp8 = jmp8 % 100000000;
        end
    end
end

endmodule
