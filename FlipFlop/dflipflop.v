module dflipflop(input clk,rst,d, output reg q,qbar);
    always @(posedge clk) begin
        if (rst == 1'b1) begin
            q = 1'b0;
            qbar = ~q;
        end
        else begin
            q<=d;
            qbar<=~d;
        end
    end
endmodule

module tb;
    wire q,qbar;
    reg clk,rst,d;
    dflipflop d1(clk,rst,d,q,qbar);
    initial begin
        $monitor ("%b   %b   %b   %b   %b",clk,rst,d,q,qbar);
        rst = 1'b0;
        {clk,d} = 2'b10;
        #1;
        {clk,d} = 2'b01;
        #1;
        {clk,d} = 2'b11;
        #1;
    end
endmodule