
/*
 =============================================================================
   PORT TASK BINDING EXAMPLE
 =============================================================================
    logic clk;
    logic rst_n;

    // PORT_TASKS:
    // - start_clock
    // - stop_clock
    modport sink (input clk,input rst_n);


    // PORT_TASKS:
    // - measure_p
    modport source (input clk,input rst_n);
*/

  logic clk;
  logic rst_n;
  logic clk_en;

  initial begin
      clk        = 1'b0;
      clk_en     = 1'b0;
      rst_n      = 1'b1;
  end

  // Clock logic
  always begin
    if (clk_en) begin
        clk = 1'b1;
        #(PERIOD_NS * DUTY_CYCLE);
        clk = 1'b0;
        #(PERIOD_NS * (1.0 - DUTY_CYCLE));
      end 
    else begin
        clk = 1'b0;
        @(posedge clk_en);
      end
  end

  // Config modport
  modport source(
    output rst_n,
    output clk_en,
    output clk,
    import task disable_clock(),
    import task enable_clock(),
    import task assert_rst(input int num_cycles)
  );

  modport sink (
    input rst_n,
    input clk_en,
    input clk,
    import task measure_clk(
    input  int  num_periods,
    output real avg_period_ns,
    output real duty_cycle_pct
  )
  );