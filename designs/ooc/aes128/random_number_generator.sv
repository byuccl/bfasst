/*

*/
`default_nettype none

module RandomNumberGenerator #(parameter seed=0) (
  input wire logic clk,
  input wire logic reset,
  output logic reg [127:0] random_number
);

  reg [127:0] seed;

  always @(posedge clk or posedge reset) begin
    if (reset)
      seed <= 0;  // Reset the seed value
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