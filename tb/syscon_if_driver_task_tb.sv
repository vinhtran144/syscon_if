`timescale 1ns / 1ps
module syscon_if_driver_task_tb;
    syscon_if syscon_inst();

    initial begin
        $display("Hello World from driver");
        $stop;
    end
endmodule : syscon_if_driver_task_tb
