/*
* Generates a random number based on a linear feedback shift register.
*/

module RandomNumberGenerator #(
  parameter int RANDOM_WIDTH = 32,
  parameter int SEED = 0
) (
  input logic clk,
  input logic reset,
  output logic [RANDOM_WIDTH-1:0] random_number
);
  
  reg [RANDOM_WIDTH-1:0] seed;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      seed <= SEED;  // Reset the seed value
    else begin
      // Generate a new random number based on the previous seed
      seed <= seed ^ (seed << 13) ^ (seed >> 17) ^ (seed << 5);
    end
  end

  always @(posedge clk) begin
    if (reset)
      random_number <= 0;  // Reset the random number
    else
      random_number <= seed;  // Output the current seed as the random number
  end

  
endmodule

