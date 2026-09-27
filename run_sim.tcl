# Define output build directory
set BUILD_DIR "build"

# Create build folder if it doesn't exist
if {![file exists $BUILD_DIR]} {
    file mkdir $BUILD_DIR
}

# Redirect transcript logging to build/transcript
transcript file "$BUILD_DIR/transcript"

# Clean up previous build artifacts inside build/
if {[file exists "$BUILD_DIR/work"]} {
    vdel -lib "$BUILD_DIR/work" -all
}

# Create and map local work library inside build/
vlib "$BUILD_DIR/work"
vmap work "$BUILD_DIR/work"

# Compile all source files into build/work
# -sv      : Enables SystemVerilog parsing
# -mfcu    : Multi-file compilation unit (shares macros across files)
# -work    : Specifies target library location
# -f       : Reads arguments and sources from syscon_if_filelist.f
vlog -sv -mfcu -work "$BUILD_DIR/work" -f syscon_if_filelist.f

# Load top-level testbench module into simulator using the build library
# -wlf     : Directs output waveform dump into build/
vsim -work "$BUILD_DIR/work" -wlf "$BUILD_DIR/vsim.wlf" work.syscon_if_driver_task_tb

# Run simulation until completion
run -all