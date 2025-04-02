module PROCESS_ELEMENT # ( parameter WIDTH = 4) (
  input wire CLK,
  input wire RST,
  input wire Clear,
  input wire [WIDTH - 1: 0] A_IN,
  input wire [WIDTH - 1: 0] B_IN,
  output reg [WIDTH - 1: 0] A_OUT,
  output reg [WIDTH -1: 0] B_OUT,   
  output reg [2*WIDTH : 0] Result         
);

wire [2*WIDTH-1:0] product;
wire [2*WIDTH:0] res;
MULTIPLIER #(WIDTH) multiplier_inst (.a(A_IN), .b(B_IN), .product(product));
ADDER #(WIDTH) adder_inst (.A(Result), .B(product), .SUM(res));
always @ ( posedge CLK or posedge RST )
begin
if(RST)
  begin
     Result = 8'b0000_0000;      
     A_OUT  <= 4'b0000;
     B_OUT  <= 4'b0000;
   end
else if(Clear)
  begin
     Result <= 0;      
     A_OUT  <= A_IN;
     B_OUT  <= B_IN;
   end
  else 
   begin
     Result <= res;
     A_OUT  <=  A_IN ;
     B_OUT  <=  B_IN ;
   end   
end
endmodule
