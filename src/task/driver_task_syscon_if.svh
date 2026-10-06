task automatic enable_clock();
    clk_en = 1'b1;
endtask

task automatic disable_clock();
    clk_en = 1'b0;
endtask

task automatic assert_rst(input int num_cycles);
    rst_n = 1'b0;

    // assert_rst will automatically enable clock
    if(!clk_en) begin
        $display("Warning: Assert reset while clock is disabled, enabling clock...");
        clk_en = 1'b1;
    end

    // Hold low for number of cycles
    repeat (num_cycles) @(posedge clk);

    rst_n <= 1'b1; 
endtask