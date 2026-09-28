
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

# Load top-level testbench module into simulator using the build library
vsim work.syscon_if_driver_task_tb

# Run simulation until completion
run -all