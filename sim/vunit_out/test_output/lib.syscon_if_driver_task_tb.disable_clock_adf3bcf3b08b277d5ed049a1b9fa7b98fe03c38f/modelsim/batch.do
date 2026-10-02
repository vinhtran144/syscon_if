onerror {quit -code 1}
source "D:/github/project/syscon_if/sim/vunit_out/test_output/lib.syscon_if_driver_task_tb.disable_clock_adf3bcf3b08b277d5ed049a1b9fa7b98fe03c38f/modelsim/common.do"
set failed [vunit_load]
if {$failed} {quit -code 1}
set failed [vunit_run]
if {$failed} {quit -code 1}
quit -code 0
