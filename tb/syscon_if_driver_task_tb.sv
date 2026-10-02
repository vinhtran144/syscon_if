`timescale 1ns / 1ps
`include "vunit_defines.svh"


module syscon_if_driver_task_tb;
    syscon_if syscon_inst();

    virtual syscon_if.source syscon_src = syscon_inst.source;

    // initial begin
    //     syscon_src = syscon_inst.source;
    //     // $display("Hello World from driver");
    //     // $stop;
    // end

    `TEST_SUITE begin
        `TEST_CASE("initial_clock") begin
            `CHECK_EQUAL(syscon_src.clk_en, 1'b0, "Source clock not disable upon initialize");
        end
        `TEST_CASE("enable_clock") begin
            syscon_src.enable_clock();
            `CHECK_EQUAL(syscon_src.clk_en, 1'b1, "Source modport failed to enable clock");
        end
        `TEST_CASE("disable_clock") begin
            syscon_src.disable_clock();
            `CHECK_EQUAL(syscon_src.clk_en, 1'b0, "Source modport failed to disable clock");
        end
    end
endmodule : syscon_if_driver_task_tb
