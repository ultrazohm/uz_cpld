// 4 bit oscillating LED pattern
module count_osc (led);

  output [7:0]  led;
  reg    [3:0]  c_delay;

  defparam I1.TIMER_DIV = "1048576";
  OSCTIMER I1 (.DYNOSCDIS(1'b0), .TIMERRES(1'b0), .OSCOUT(osc_clk), .TIMEROUT(tmr_clk));

  assign led[0]   = (c_delay <= 4'd5) ;
  assign led[1]   = !led[0] ;
  assign led[3:2] = led[1:0] ;
  assign led[7:4] = led[3:0] ;

  always @(posedge tmr_clk) 
    begin
      if (c_delay == 4'd10)
        c_delay <= 4'd0 ;
      else
        c_delay <= c_delay + 1 ;
    end

endmodule

