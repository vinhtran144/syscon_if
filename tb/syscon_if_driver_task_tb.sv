`timescale 1ns / 1ps
`include "vunit_defines.svh"


module syscon_if_driver_task_tb;
    localparam int  RESET_CYCLES = 5;

    syscon_if syscon_inst();

    virtual syscon_if.source syscon_src = syscon_inst.source;

    // initial begin
    //     syscon_src = syscon_inst.source;
    //     // $display("Hello World from driver");
    //     // $stop;
    // end

    `TEST_SUITE begin
        `TEST_SUITE_SETUP begin

        end

        `TEST_CASE("test_clock_en") begin
            `CHECK_EQUAL(syscon_src.clk_en, 1'b0, "Source clock not disable upon initialize");

            syscon_src.enable_clock();
            `CHECK_EQUAL(syscon_src.clk_en, 1'b1, "Source modport failed to enable clock");

            syscon_src.disable_clock();
            `CHECK_EQUAL(syscon_src.clk_en, 1'b0, "Source modport failed to disable clock");

            //syscon_src.enable_clock();
        end

        `TEST_CASE("test_reset_assert") begin
            automatic int cycle_count = 0;
            
            // Ensures rst_n is normally HIGH
            `CHECK_EQUAL(syscon_inst.rst_n, 1'b1, "Reset should be HIGH before assertion"); 
            fork
                // Thread 1: Initialize assert reset
                begin
                    syscon_src.assert_rst(RESET_CYCLES);
                end

                // Thread 2: Test reset timing
                begin
                    @(posedge syscon_inst.clk);
                    `CHECK_EQUAL(syscon_inst.rst_n, 1'b0, "rst_n failed to assert before 1st cycle");
                    cycle_count = 1;
                    
                    while (syscon_inst.rst_n == 1'b0) begin
                        // increase cycle_count every clock edge
                        @(posedge syscon_inst.clk);
                        if (syscon_inst.rst_n == 1'b0) cycle_count++;
                    end

                    // Check if the rst_n was hold LOW for desired number of cycles
                    `CHECK_EQUAL(cycle_count, RESET_CYCLES, 
                       "rst_n was not held low for desired number of cycles");
                end
            join
        end
        
    end

    `WATCHDOG(1000ns);
endmodule : syscon_if_driver_task_tb
