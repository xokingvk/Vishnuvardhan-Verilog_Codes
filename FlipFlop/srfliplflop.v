module srflipflop(input clk,rst,s,r, output reg q,qbar);
    always @(posedge clk) begin
        if (rst == 1'b1) begin
            q = 1'b0;
            qbar = ~q;
        end
        else begin
            case ({s,r}) 
                2'b00: {q,qbar} <= {q,qbar};
                2'b01: {q,qbar} <= 2'b01;
                2'b10: {q,qbar} <= 2'b10;
                2'b11: {q,qbar} <= 2'bxx;
            endcase
        end
    end
endmodule

module tb;
    wire q,qbar;
    reg clk,rst,s,r;
    integer m;
    srflipflop s1(clk,rst,s,r,q,qbar);
    initial begin
        $monitor ("%b   %b   %b   %b   %b   %b",clk,rst,s,r,q,qbar);
        rst = 1'b0;
        for (m = 0; m <= 8; m = m+1) begin
            {s,r,clk} = m;
            #1;
        end
        #1;
        rst = 1'b1;
        for (m = 0; m <= 8; m = m+1) begin
            {s,r,clk} = m;
            #1;
        end
    end
endmodule