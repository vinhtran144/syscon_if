onerror {quit -code 1}
source "D:/github/project/syscon_if/sim/vunit_out/test_output/lib.syscon_if_driver_task_tb.initial_clock_5f9fdfaef4c3fd23ed87b27825a6f82f8340ee01/modelsim/common.do"
set failed [vunit_load]
if {$failed} {quit -code 1}
set failed [vunit_run]
if {$failed} {quit -code 1}
quit -code 0
