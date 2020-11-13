`timescale 1ns / 1ps

module lock(
input sys_clk,  //��ʱ��
input rst_n,    //reset����
//�����ť������������
input up_button,  
input down_button,
input left_button,
input right_button,
input middle_button,
input mode,   //SW7���ؿ���ģʽ
output wire ledlow,     //SW7��Ӧ��LED��
output wire [7:0] ledbit,    //�������ʾλ��Ϣ
output wire [6:0] ledshow,   //ǰ��λ�����ÿ����Ϣ
output wire [6:0] ledshow2,  //����λ�����ÿ����Ϣ
output reg [7:0] leddown     //8��СLED�ƣ���ˮ��ʱ
);

wire [63:0] timer;
wire [63:0] led_timer;
wire [63:0] pwd_cng_timer;
wire [63:0] jmp1;
wire [63:0] jmp2;
wire [63:0] jmp3;
wire [63:0] jmp4;
wire [63:0] jmp5;
wire [63:0] jmp6;
wire [63:0] jmp7;
wire [63:0] jmp8;
wire [63:0] main_timer;
wire [63:0] left_timer;
wire [63:0] right_timer;
wire [63:0] up_timer;
wire [63:0] down_timer;
wire [63:0] middle_timer;

reg lock_status;    //�Ƿ�Ϊ��ס״̬
wire load_status;   //�Ƿ�Ϊ�޸�����״̬
wire read_status;   //�Ƿ�Ϊ��������״̬
reg succ_status;    //�Ƿ�ɹ�����

reg [7:0] is_jmp;   //��ǰѡ��λ��ʵ����˸��
reg [7:0] choose;   //ָ��

clock_make U1(
.sys_clk(sys_clk),
.rst_n(rst_n),
.timer(timer),
.led_timer(led_timer),
.load_status(load_status),
.read_status(read_status),
.lock_status(lock_status),
.is_jmp(is_jmp),
.pwd_cng_timer(pwd_cng_timer),
.middle_button(middle_button),
.left_button(left_button),
.right_button(right_button),
.up_button(up_button),
.down_button(down_button),
.jmp1(jmp1),
.jmp2(jmp2),
.jmp3(jmp3),
.jmp4(jmp4),
.jmp5(jmp5),
.jmp6(jmp6),
.jmp7(jmp7),
.jmp8(jmp8),
.main_timer(main_timer),
.left_timer(left_timer),
.right_timer(right_timer),
.up_timer(up_timer),
.down_timer(down_timer),
.middle_timer(middle_timer)
);

reg [7:0] numbit;    //������ʾλ��Ϣ
reg [3:0] number1;   //ǰ��λ�����������Ϣ
reg [3:0] number2;   //����λ�����������Ϣ

//�������ֶ�4λ
reg [3:0] pwd1;      
reg [3:0] pwd2;
reg [3:0] pwd3;
reg [3:0] pwd4;

reg [3:0] pwds;      //��ǰ��������

reg [3:0] number_1;
reg [3:0] number_2;
reg [3:0] number_3;
reg [3:0] number_4;
reg [3:0] number_5;
reg [3:0] number_6;
reg [3:0] number_7;
reg [3:0] number_8;

digital_put U2(
.sys_clk(sys_clk),
.rst_n(rst_n),
.timer(timer),
.numbit(numbit),
.number1(number1),
.number2(number2),
.ledbit(ledbit),
.ledshow(ledshow),
.ledshow2(ledshow2)
);

assign ledlow = mode;
assign read_status = ~mode;
assign load_status = mode;

initial
begin
    numbit <= 8'b11111111;
    is_jmp <= 8'b00000000;
    number1 <= 4'd0;
    number2 <= 4'd0;
    number_1 <= 4'd0;
    number_2 <= 4'd0;
    number_3 <= 4'd0;
    number_4 <= 4'd0;
    number_5 <= 4'd0;
    number_6 <= 4'd0;
    number_7 <= 4'd0;
    number_8 <= 4'd0;
    pwd1 <= 4'd1;
    pwd2 <= 4'd0;
    pwd3 <= 4'd0;
    pwd4 <= 4'd0;
    pwds <= 4'd0;
    lock_status <= 1'b0;
    succ_status <= 1'b0;
    choose <= 4'b0;
end

always@(posedge sys_clk or negedge rst_n)
begin
    //��ʼ��
    if(~rst_n)
    begin
        leddown <= 8'b11111111;
        lock_status = 1'b0;
    end
    //��ˮ�Ƽ�ʱ
    else if(read_status == 1'b1)
    begin
        if(led_timer == 64'd199_999_999) //49_999_999
            begin
                leddown <= 8'b11111110;
            end
            else if(led_timer == 64'd399_999_999)//99_999_999
            begin
                leddown <= 8'b11111100;
            end
            else if(led_timer == 64'd599_999_999)//149_999_999
            begin
                leddown <= 8'b11111000;
            end
            else if(led_timer == 64'd799_999_999)//199_999_999
            begin
                leddown <= 8'b11110000;
            end
            else if(led_timer == 64'd999_999_999)//249_999_999
            begin
                leddown <= 8'b11100000;
            end
            else if(led_timer == 64'd1_199_999_999)//299_999_999
            begin
                leddown <= 8'b11000000;
            end
            else if(led_timer == 64'd1_399_999_999)//349_999_999
            begin
                leddown <= 8'b10000000;
            end
            else if(led_timer == 64'd1_599_999_999)//399_999_999
            begin
                leddown <= 8'b00000000;
            end
            else if(led_timer == 64'd1_799_999_999)//449_999_999
            begin
                leddown <= 8'b11111111;
                lock_status = 1'b1;    //��ʱ��ס
            end
        end
        
        //read_status=0 ,��������
        else
        begin
            leddown <= 8'b10101010;
        end
    end

always@(posedge sys_clk)
begin
    //�ɹ����� -HCC
    if(succ_status == 1'b1)
    begin
        number_5 <= 4'd14;
        number_6 <= 4'd12;
        number_7 <= 4'd13;
        number_8 <= 4'd13;
    end
    else
    begin
         //δ�ڹ涨ʱ���ڽ���  Fail
        if(lock_status == 1'b1)
        begin
            number_5 <= 4'd15;
            number_6 <= 4'd10;
            number_7 <= 4'd1;
            number_8 <= 4'd11;
        end
        else
        //������ CALL
        begin
            number_5 <= 4'd13;
            number_6 <= 4'd10;
            number_7 <= 4'd11;
            number_8 <= 4'd11;
        end
    end
end

//���Ҽ�����ָ��ָ��
always@(posedge sys_clk)
begin
    if(choose == 8'd0)
    begin
        if(right_timer == 64'd9_999_999)
        begin
            choose = 8'd1;
        end
    end
    else if(choose == 8'd1)
    begin
        if(left_timer == 64'd9_999_999)
        begin
            choose = 8'd0;
        end
        else if(right_timer == 64'd9_999_999)
        begin
            choose = 8'd2;
        end
    end
    else if(choose == 8'd2)
    begin
        if(left_timer == 64'd9_999_999)
        begin
            choose = 8'd1;
        end
        else if(right_timer == 64'd9_999_999)
        begin
            choose = 8'd3;
        end
    end
    else if(choose == 8'd3)
    begin
        if(left_timer == 64'd9_999_999)
        begin
            choose = 8'd2;
        end
    end
end

//���¼�������ֵ
always@(posedge sys_clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        number_1 = 4'd0;
        number_2 = 4'd0;
        number_3 = 4'd0;
        number_4 = 4'd0;
    end
    else
    begin
        if(choose == 4'd0)
        begin
            if(up_timer == 64'd9_999_999)
            begin
                if(number_1 < 4'd9)
                begin
                    number_1 = number_1 + 1'b1;
                end
            end
            if(down_timer == 64'd9_999_999)
            begin
                if(number_1 > 4'd0)
                begin
                    number_1 = number_1 - 1'b1;
                end
            end
        end
        if(choose == 4'd1)
        begin
            if(up_timer == 64'd9_999_999)
            begin
                if(number_2 < 4'd9)
                begin
                    number_2 = number_2 + 1'b1;
                end
            end
            if(down_timer == 64'd9_999_999)
            begin
                if(number_2 > 4'd0)
                begin
                    number_2 = number_2 - 1'b1;
                end
            end
        end
        if(choose == 4'd2)
        begin
            if(up_timer == 64'd9_999_999)
            begin
                if(number_3 < 4'd9)
                begin
                    number_3 = number_3 + 1'b1;
                end
            end
            if(down_timer == 64'd9_999_999)
            begin
                if(number_3 > 4'd0)
                begin
                    number_3 = number_3 - 1'b1;
                end
            end
        end
        if(choose == 4'd3)
        begin
            if(up_timer == 64'd9_999_999)
            begin
                if(number_4 < 4'd9)
                begin
                    number_4 = number_4 + 1'b1;
                end
            end
            if(down_timer == 64'd9_999_999)
            begin
                if(number_4 > 4'd0)
                begin
                    number_4 = number_4 - 1'b1;
                end
            end
        end
    end
end

always@(posedge sys_clk or negedge rst_n)
begin
    if(~rst_n)
    //��ʼ�������úͳ�ʼĬ��������
    begin
        pwd1 <= 4'd2;
        pwd2 <= 4'd0;
        pwd3 <= 4'd2;
        pwd4 <= 4'd0;
        pwds <= 4'b0000;
        succ_status <= 1'b0;
    end
    else
    begin
        if(pwd1 == number_1)
        begin
            pwds[3]=1'b1;
        end
        else
        begin
            pwds[3]=1'b0;
        end
        if(pwd2 == number_2)
        begin
            pwds[2]=1'b1;
        end
        else
        begin
            pwds[2]=1'b0;
        end
        if(pwd3 == number_3)
        begin
            pwds[1]=1'b1;
        end
        else
        begin
            pwds[1]=1'b0;
        end
        if(pwd4 == number_4)
        begin
            pwds[0]=1'b1;
        end
        else
        begin
            pwds[0]=1'b0;
        end
        //δ����״̬��
        if(lock_status == 1'b0)
        begin
            //��ȡ״̬ ������ȷ����
            if(read_status == 1'b1)
            begin
                if(middle_timer == 64'd9_999_999)
                begin
                    if(pwds == 4'b1111)
                    begin
                        succ_status <= 1'b1;
                    end
                    else
                    begin
                        succ_status <= 1'b0;
                    end
                end
            end
            //�Ƕ�ȡ״̬
            else
            begin
                if(load_status == 1'b1)
                begin
                    //����״̬�� ��������---------------------------------------------
                    if(middle_timer == 64'd9_999_999)
                    begin
                        pwd1 <= number_1;
                        pwd2 <= number_2;
                        pwd3 <= number_3;
                        pwd4 <= number_4;
                        
                        succ_status <= 1'b0;
                    end
                end
            end
        end
    end
end

//������˸��λ��
always@(posedge sys_clk)
begin
    if(choose == 8'd0)
    begin
        is_jmp <= 8'b10000000;
    end
    else if(choose == 8'd1)
    begin
        is_jmp <= 8'b01000000;
    end
    else if(choose == 8'd2)
    begin
        is_jmp <= 8'b00100000;
    end
    else if(choose == 8'd3)
    begin
        is_jmp <= 8'b00010000;
    end
end

//��˸��ѡ������
always@(posedge sys_clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        numbit <= 8'b11111111;
        number1 <= 4'd0;
        number2 <= 4'd0;
        //number_1 <= 4'd1;
        //number_2 <= 4'd2;
        //number_3 <= 4'd3;
        //number_4 <= 4'd4;
        //number_5 <= 4'd5;
        //number_6 <= 4'd6;
        //number_7 <= 4'd7;
        //number_8 <= 4'd8;
    end
    else if(timer <= 64'd249999)
    begin
        numbit = 8'b10001000;
        if(is_jmp[7] == 1'b1)
        begin
            if(jmp1 <= 50000000)
            begin
                number1 = number_1;
            end
            else
            begin
                numbit[7] = 1'b0;
            end
        end
        else
        begin
            number1 = number_1;
        end
        if(is_jmp[3] == 1'b1)
        begin
            if(jmp5 <= 50000000)
            begin
                number2 = number_5;
            end
            else
            begin
                numbit[3] = 1'b0;
            end
        end
        else
        begin
            number2 = number_5;
        end
    end
    else if(timer <= 64'd499999)
    begin
        numbit = 8'b01000100;
        if(is_jmp[6] == 1'b1)
        begin
            if(jmp2 <= 50000000)
            begin
                number1 = number_2;
            end
            else
            begin
                numbit[6] = 1'b0;
            end
        end
        else
        begin
            number1 = number_2;
        end
        if(is_jmp[2] == 1'b1)
        begin
            if(jmp6 <= 50000000)
            begin
                number2 = number_6;
            end
            else
            begin
                numbit[2] = 1'b0;
            end
        end
        else
        begin
            number2 = number_6;
        end
    end
    else if(timer <= 64'd749999)
    begin
        numbit = 8'b00100010;
        if(is_jmp[5] == 1'b1)
        begin
            if(jmp3 <= 50000000)
            begin
                number1 = number_3;
            end
            else
            begin
                numbit[5] = 1'b0;
            end
        end
        else
        begin
            number1 = number_3;
        end
        if(is_jmp[1] == 1'b1)
        begin
            if(jmp7 <= 50000000)
            begin
                number2 = number_7;
            end
            else
            begin
                numbit[1] = 1'b0;
            end
        end
        else
        begin
            number2 = number_7;
        end
    end
    else if(timer <= 64'd999999)
    begin
        numbit = 8'b00010001;
        if(is_jmp[4] == 1'b1)
        begin
            if(jmp4 <= 50000000)
            begin
                number1 = number_4;
            end
            else
            begin
                numbit[4] = 1'b0;
            end
        end
        else
        begin
            number1 = number_4;
        end
        if(is_jmp[0] == 1'b1)
        begin
            if(jmp8 <= 50000000)
            begin
                number2 = number_8;
            end
            else
            begin
                numbit[0] = 1'b0;
            end
        end
        else
        begin
            number2 = number_8;
        end
    end
end

endmodule
