module tflipflop(input clk,rst,t, output reg q,qbar);
    always @(posedge clk) begin
        if (rst == 1'b1) begin
            q <= 1'b0;
            qbar <= 1'b1;
        end
        else if (t == 1) begin
            q <= ~q;
            qbar <= q;
        end
        else begin
            q<=q;
            qbar <= ~q;
        end
    end
endmodule

module tb;
    wire q,qbar;
    reg clk,rst,t;
    tflipflop t1(clk,rst,t,q,qbar);
    initial begin
        $monitor ("%b   %b   %b   %b   %b",rst,clk,t,q,qbar);
        rst = 1'b1;
        {clk,t} = 2'b10;
        #1;
        rst = 1'b0;
        {clk,t} = 2'b00;
        #1;
        {clk,t} = 2'b11;
        #1;
        {clk,t} = 2'b01;
        #1;
        {clk,t} = 2'b11;
        #1;
        {clk,t} = 2'b01;
        #1;
        {clk,t} = 2'b11;
        #1;
        {clk,t} = 2'b01;
        #1;
    end
endmodule