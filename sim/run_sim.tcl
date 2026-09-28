set tb_list [list \
    "syscon_if_driver_task_tb" \
    "syscon_if_monitor_task_tb" \
]

# Clean up previous local work library
if {[file exists "work"]} {
    vdel -lib "work" -all
}

# Create and map local work library
vlib work
vmap work work

# Compile all source files into build/work
# -sv      : Enables SystemVerilog parsing
# -mfcu    : Multi-file compilation unit (shares macros across files)
# -f       : Reads arguments and sources from syscon_if_filelist.f
vlog -sv -mfcu -f syscon_if_filelist.f

# Create set to log the results
set results [dict create]

# Iterate through the tb list
foreach tb $tb_list {
    # Execute tb
    vsim work.$tb
    
    set sim_status [catch {run -all} sim_err]
    
    # Log the results
    if {$sim_status == 0} {
        dict set results $tb "PASSED"
    } else {
        dict set results $tb "FAILED"
    }
    
    quit -sim
}
echo "\n=================================================="
echo "                 SIMULATION RESULTS: "
echo "=================================================="
dict for {tb status} $results {
    echo [format "  %-30s : %s" $tb $status]
}