`timescale 1ns / 1ps

`include "utility.vh"
`include "simon.v"
`include "round.v"
`include "key_expansion.v"

module tb_simon #(parameter n=`N, m=`M);
    
    reg clk, rst, en;
    
    reg [2*n-1:0] plaintext;
    reg [n*m-1:0] key;
    wire [2*n-1:0] ciphertext;
    wire done;
    simon s(.clk(clk), .rst(rst), .plaintext(plaintext),.ciphertext(ciphertext),.key(key), .done(done), .en(en));
    initial begin
        $dumpfile("simon_wf.vcd");
        $dumpvars(0, tb_simon);

        clk =0;
        rst = 0;
        key = 64'h1918111009080100;
        plaintext = 32'h65656877;
    end
    
    always 
    begin
        #5 clk = ~clk;
    end
    initial begin
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        rst = 1;
        @(posedge clk);
        rst = 0;
        en = 0;
        @(posedge clk);
        en = 1;
        @(posedge clk);
        en = 0;
        while(done!=1)
        begin
            @(posedge clk);
        end;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        plaintext = 23451;
        en = 1;
        @(posedge clk);
        en = 0;
        @(posedge clk);
         while(done!=1)
         begin
             @(posedge clk);
         end;
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
        $finish;
    end
endmodule
