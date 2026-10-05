from pathlib import Path
from vunit import VUnit

# Suppress the deprecation warning
VU = VUnit.from_argv(compile_builtins=False)

# Add builtins
VU.add_verilog_builtins()  

# Create design library
lib = VU.add_library("lib")

SIM_DIR = Path(__file__).parent

# Load filelist
lib.add_source_files(
    ["../src/rtl/*.sv", "../tb/*.sv", "../*.sv"],
    include_dirs=[Path("../src/rtl").as_posix(),Path("../src/task").as_posix()],
)

# Simulator options
VU.set_sim_option("modelsim.vsim_flags", ["-t", "1ps"])

# Run test suite
VU.main()