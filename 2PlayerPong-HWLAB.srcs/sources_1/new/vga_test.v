module vga_test
	(
		input wire clk, reset,
		output wire hsync, vsync,
		output wire [11:0] rgb
	);
	
	// register for Basys 2 8-bit RGB DAC 
	wire [11:0] rgb_reg;
	wire p_tick;
	wire [9:0] x,y;
	// video status output from vga_sync to tell when to route out rgb signal to DAC
	wire video_on;

        // instantiate vga_sync
        vga_sync vga_sync_unit (.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync),
                                .video_on(video_on), .p_tick(p_tick), .x(x), .y(y));
   
        // rgb buffer
        reg [9:0] ballx;
        reg [9:0] bally;
        reg [9:0] paddlelefty;
        reg [9:0] paddlerighty;
        reg [6:0] scoreleft;
        reg [6:0] scoreright;
        reg [3:0] ballsize;
        reg [3:0] paddlewidth;
        reg [6:0] paddleheight;
        initial begin
            ballx = 240;
            bally = 240;
            paddlelefty = 180;
            paddlerighty = 320;
            scoreleft = 12;
            scoreright = 43;
            ballsize = 15;
            paddlewidth = 5;
            paddleheight = 115;
        end
        game_vga_controller controller( x,
                                        y,
                                        ballx,
                                        bally,
                                        ballsize,
                                        paddlelefty,
                                        paddlerighty,
                                        paddlewidth,
                                        paddleheight,
                                        scoreleft,
                                        scoreright,
                                        rgb_reg,
                                        p_tick,
                                        clk
                                       );
        
        // output
        assign rgb = (video_on) ? rgb_reg : 12'b0;
endmodule