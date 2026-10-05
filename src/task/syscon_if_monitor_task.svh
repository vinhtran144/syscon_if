task automatic measure_clk(
  input  int  num_periods,    
  output real period_ns,  
  output real duty_cycle  
);
    time t_start, t_neg, t_end;
    real high_t, low_t;
    real total_ns   = 0.0;
    real total_high = 0.0;

    // Clear default outputs
    period_ns  = 0.0;
    duty_cycle = 0.0;

    // CHeck valid input
    if (num_periods <= 0) return;

    // Align first rising clock
    @(posedge clk);
    for (int i = 0; i < num_periods; i++) begin
        // Get current time
        t_start = $realtime;

        // Measure active high pulse time
        @(negedge clk);
        t_neg = $realtime;
        high_t = (t_neg - t_start);

        // Measure active low pulse time 
        @(posedge clk);
        t_end = $realtime;
        low_t = (t_end - t_neg);

        // Accumulate total times
        total_ns   += (high_t + low_t);
        total_high += high_t;
    end

  // Calculate final outputs
  period_ns  = total_ns / num_periods;
  duty_cycle = total_high / total_ns;

endtask