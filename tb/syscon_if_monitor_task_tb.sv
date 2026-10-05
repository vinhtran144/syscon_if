`timescale 1ns / 1ps
`include "vunit_defines.svh"

module syscon_if_monitor_task_tb;
    syscon_if #(.PERIOD_NS(12.0), .DUTY_CYCLE (0.4)) syscon_inst ();

    virtual syscon_if #(.PERIOD_NS(12.0), .DUTY_CYCLE (0.4)).source syscon_src  = syscon_inst.source;
    virtual syscon_if #(.PERIOD_NS(12.0), .DUTY_CYCLE (0.4)).sink   syscon_sink = syscon_inst.sink;

    `TEST_SUITE begin
        `TEST_SUITE_SETUP begin
            syscon_src.enable_clock();
        end

        `TEST_CASE("test_measure_clock") begin
            automatic real period_ns;
            automatic real duty_cycle;

            // Measure period and duty cycle over 20 cycles
            syscon_sink.measure_clk(20, period_ns, duty_cycle);
    
            // Check measure result
            `CHECK_EQUAL_VARIANCE(period_ns, 12.0, 0.001, "Measured period should be 12.0ns");
            `CHECK_EQUAL_VARIANCE(duty_cycle, 0.4, 0.05, "Measured duty cycle should be 0.4");
        end
    end
    `WATCHDOG(1000ns);
endmodule : syscon_if_monitor_task_tb
