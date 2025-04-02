module MULTIPLIER #(
    parameter WIDTH = 4
)(
input wire [WIDTH-1:0] a,
input wire [WIDTH-1:0] b,
output wire [(2*WIDTH)-1:0] product
);
wire [(2*WIDTH)-2:0] p1;
wire [(2*WIDTH)-2:0] p2;
wire [(2*WIDTH)-2:0] p3;
wire [(2*WIDTH)-2:0] p4;
assign p1 = {{WIDTH-1{1'b0}}, (a & {WIDTH{b[0]}})};
assign p2 = {{WIDTH-2{1'b0}}, (a & {WIDTH{b[1]}}), {1{1'b0}}};
assign p3 = {{WIDTH-3{1'b0}}, (a & {WIDTH{b[2]}}), {2{1'b0}}};
assign p4 = {{WIDTH-4{1'b0}}, (a & {WIDTH{b[3]}}), {3{1'b0}}};
Partial_product #(WIDTH) g0 (p1, p2, p3, p4, product);
endmodule
