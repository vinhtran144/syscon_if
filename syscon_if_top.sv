`timescale 1ns / 1ps
import syscon_if_pkg::*;


interface syscon_if #(`include "syscon_if_io_param.svh")(`include "syscon_if_io_sig.svh");
    `include "syscon_if_port_logic.svh"
    

    `include "syscon_if_driver_task.svh"
    `include "syscon_if_monitor_task.svh"
    

endinterface : syscon_if

