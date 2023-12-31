// Listing 14.9
module timer
   (
    input wire clk, reset,
    input wire timer_start, timer_tick,
    output wire timer_up
   );

   // signal declaration
   reg [6:0] timer_reg, timer_next;
   localparam settime = 7'b1111111;

   // registers
   always @(posedge clk, posedge reset)
      if (reset)
         timer_reg <= settime;
      else
         timer_reg <= timer_next;

   // next-state logic
   always @*
      if (timer_start)
         timer_next = settime;
      else if ((timer_tick) && (timer_reg != 0))
         timer_next = timer_reg - 1;
      else
         timer_next = timer_reg;
   // output
   assign timer_up = (timer_reg==0);

endmodule