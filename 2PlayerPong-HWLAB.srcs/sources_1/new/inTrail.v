module inTrail(
    input clk,
    input [9:0] x, 
    input [9:0] y, 
    input [9:0] ballx, 
    input [9:0] bally, 
    input [3:0] ballsize, 
    output reg [12:0] checkInTrail_withrgb
);
    reg [9:0] ballxs[3:0];
    reg [9:0] ballys[3:0];
    reg [26:0] counter;
    reg [2:0] index; // Replacing loop variable with a register
    initial begin
        checkInTrail_withrgb[11:0] <= 12'hFFF;
        counter = 0;
        ballxs[0] = 319;
        ballys[0] = 239;
        ballxs[1] = 319;
        ballys[1] = 239;
        ballxs[2] = 319;
        ballys[2] = 239;
        ballxs[3] = 319;
        ballys[3] = 239;
    end

    always @(x or y) begin
        index = 0;
        // Use a while loop for combinational logic
        while (index < 4) begin
            if (x >= ballxs[index] - (7-1)/2 && x <= ballxs[index] + (7-1)/2 &&
                y >= ballys[index] - (7-1)/2 && y <= ballys[index] + (7-1)/2) begin
                checkInTrail_withrgb[12] <= 1;
            end
            index = index + 1;
        end
    end

    always @(posedge clk) begin
        // Reset the output
        checkInTrail_withrgb[12] <= 0;

        // Increment counter
        if(counter < 27'b1011_1110_1011_1100_0010_0000_000)
            counter <= counter + 1;

        // Update positions
        else begin
            index = 3;
            counter <= 0;
            while (index > 0) begin
                ballxs[index] <= ballxs[index-1];
                ballys[index] <= ballys[index-1];
                index = index - 1;
            end
            ballxs[0] <= ballx;
            ballys[0] <= bally;
        end
    end
endmodule