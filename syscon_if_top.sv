`timescale 1ns / 1ps
import syscon_if_pkg::*;


interface syscon_if #(`include "io_param_syscon_if.svh")(`include "io_sig_syscon_if.svh");
    `include "port_logic_syscon_if.svh"
    

    `include "driver_task_syscon_if.svh"
    `include "monitor_task_syscon_if.svh"
    
endinterface: syscon_if

