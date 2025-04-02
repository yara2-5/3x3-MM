module FA (
  input wire x,
  input wire y,
  input wire z,
  output wire S,
  output wire C
);
  assign S = x ^ y ^ z;
  assign C = (x & y) | (y & z) | (z & x);
endmodule

module ADDER #(parameter WIDTH = 4) (
  input  [2*WIDTH:0]  A,
  input  [2*WIDTH-1:0] B,
  output [2*WIDTH:0]     SUM
);
wire [2*WIDTH+1:0] carry;
wire [2*WIDTH:0] B_wire;
assign B_wire = {1'b0, B};
assign carry[0] = 1'b0;  
genvar i;
generate
for (i = 0; i < 2*WIDTH+1; i = i + 1) begin: FULL_ADDERS
FA fa (
  .x(A[i]),
  .y(B_wire[i]),
  .z(carry[i]),
  .S(SUM[i]),
  .C(carry[i+1])
   );
end
endgenerate
endmodule
