onerror {quit -code 1}
source "D:/github/project/syscon_if/sim/vunit_out/test_output/lib.syscon_if_driver_task_tb.enable_clock_4428ce95306654a49c9972f474d595a46ff8d21e/modelsim/common.do"
set failed [vunit_load]
if {$failed} {quit -code 1}
set failed [vunit_run]
if {$failed} {quit -code 1}
quit -code 0
