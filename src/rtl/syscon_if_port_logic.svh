
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
  modport sink (
    input clk_en,
    input clk,
    input rst_n,
    import task disable_clock(),
    import task enable_clock()
  );

  modport source(
    input clk_en,
    output clk,
    output rst_n,
    import task disable_clock(),
    import task enable_clock()
  );