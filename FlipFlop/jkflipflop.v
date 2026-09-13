module jkflipflop(input clk,rst,j,k, output reg q,qbar);
    always @(posedge clk) begin
        if (rst == 1'b1) begin
            q = 1'b0;
            qbar = ~q;
        end
        else begin
            case ({j,k}) 
                2'b00: {q,qbar} <= {q,qbar};
                2'b01: {q,qbar} <= 2'b01;
                2'b10: {q,qbar} <= 2'b10;
                2'b11: {q,qbar} <= ~{q,qbar};
            endcase
        end
    end
endmodule

module tb;
    wire q,qbar;
    reg clk,rst,j,k;
    jkflipflop j1(clk,rst,j,k,q,qbar);
    initial begin
        $monitor ("%b   %b   %b   %b   %b   %b",clk,rst,j,k,q,qbar);
        rst = 1'b0;
        {clk,j,k} = 3'b101;
        #1;
        {clk,j,k} = 3'b010;
        #1;
        {clk,j,k} = 3'b110;
        #1;
        {clk,j,k} = 3'b000;
        #1;
        {clk,j,k} = 3'b100;
        #1;
        {clk,j,k} = 3'b011;
        #1;
        {clk,j,k} = 3'b111;
        #1;
    end
endmodule