module srflipflop (input clk,rst,s,r, output reg q,qbar);
    always @(posedge clk) begin
        if (rst ==1) begin
            q <=0;
            qbar <=1;
        end
        else begin
            case ({s,r})
                2'b00: {q,qbar}<={q,qbar};
                2'b10: {q,qbar}<= 2'b10;
                2'b01: {q,qbar}<= 2'b01;
                2'b11: {q,qbar}<= 2'bxx;
            endcase
        end
    end
endmodule

module bit3counter(input clk,rst, output [2:0]q,qbar);
    wire [2:0]s,r;
    assign s[2] =(qbar[2]&q[1]&q[0]);
    assign s[1] =(qbar[1]&q[0]);
    assign s[0] =qbar[0];
    assign r[2] =(q[2]&q[1]&q[0]);
    assign r[1] =(q[1]&q[0]);
    assign r[0] =q[0];
    srflipflop s1(clk,rst,s[2],r[2],q[2],qbar[2]);
    srflipflop s2(clk,rst,s[1],r[1],q[1],qbar[1]);
    srflipflop s3(clk,rst,s[0],r[0],q[0],qbar[0]);
endmodule

module tb;
    reg clk,rst;
    wire [2:0]q,qbar;
    bit3counter b1(clk,rst,q,qbar);
    always #5 clk = ~clk;
    initial begin
        $monitor ("%b  %b  %b",q[2],q[1],q[0]);
        {clk,rst} = 2'b01;
        #10;
        rst = 0;
        #80;
        $finish;
    end
endmodule