task automatic enable_clock();
    clk_en = 1'b1;
endtask

task automatic disable_clock();
    clk_en = 1'b0;
endtask