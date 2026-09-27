`timescale 1ns / 1ps
module syscon_if_monitor_task_tb;
    syscon_if syscon_inst();

    initial begin
        $display("Hello World from monitor");
        $stop;
    end
endmodule : syscon_if_monitor_task_tb
