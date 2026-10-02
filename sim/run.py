from pathlib import Path
from vunit import VUnit

# 1. Pass compile_builtins=False to suppress the deprecation warning
VU = VUnit.from_argv(compile_builtins=False)

# 2. Explicitly add builtins
VU.add_verilog_builtins()  # Enables `TEST_SUITE, `TEST_CASE, `CHECK_* macros
# VU.add_vhdl_builtins()   # Uncomment if you also use VHDL VUnit components

# 3. Create design library
lib = VU.add_library("lib")

SIM_DIR = Path(__file__).parent

# 4. Load filelist
lib.add_source_files(
    ["../src/rtl/*.sv", "../tb/*.sv", "../*.sv"],
    include_dirs=[Path("../src/rtl").as_posix(),Path("../src/task").as_posix()],
)

# 5. Simulator options
VU.set_sim_option("modelsim.vsim_flags", ["-t", "1ps"])

# 6. Run test suite
VU.main()