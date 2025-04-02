module SYSTOLIC_ARRAY # ( parameter WIDTH = 4 , ROW = 3 , COLOUM = 3 )  ( 
  input wire CLK,
  input wire RST,
  input wire [(WIDTH*ROW)-1 : 0] A_IN_ROW_1,
  input wire [(WIDTH*ROW)-1 : 0] A_IN_ROW_2,
  input wire [(WIDTH*ROW)-1 : 0] A_IN_ROW_3,
  input wire [(WIDTH*COLOUM)-1 : 0] B_IN_COLOUM_1,
  input wire [(WIDTH*COLOUM)-1 : 0] B_IN_COLOUM_2,
  input wire [(WIDTH*COLOUM)-1 : 0] B_IN_COLOUM_3,
  output wire [2*WIDTH : 0] OUT_1x1,
  output wire [2*WIDTH : 0] OUT_1x2,
  output wire [2*WIDTH : 0] OUT_1x3,
  output wire [2*WIDTH : 0] OUT_2x1,
  output wire [2*WIDTH : 0] OUT_2x2,
  output wire [2*WIDTH : 0] OUT_2x3,
  output wire [2*WIDTH : 0] OUT_3x1,
  output wire [2*WIDTH : 0] OUT_3x2,
  output wire [2*WIDTH : 0] OUT_3x3            
);

wire [WIDTH-1  : 0] A_OUT_ROW_1;
wire [WIDTH-1  : 0] A_OUT_ROW_2;
wire [WIDTH-1  : 0] A_OUT_ROW_3;
wire [WIDTH-1  : 0] B_OUT_COLOUM_1;
wire [WIDTH-1  : 0] B_OUT_COLOUM_2;
wire [WIDTH-1  : 0] B_OUT_COLOUM_3;


wire [WIDTH-1  : 0] A1x1;
wire [WIDTH-1  : 0] A1x2;
wire [WIDTH-1  : 0] A1x3;
wire [WIDTH-1  : 0] A2x1;
wire [WIDTH-1  : 0] A2x2;
wire [WIDTH-1  : 0] A2x3;
wire [WIDTH-1  : 0] A3x1;
wire [WIDTH-1  : 0] A3x2;
wire [WIDTH-1  : 0] A3x3; 

wire [WIDTH-1  : 0] B1x1;
wire [WIDTH-1  : 0] B1x2;
wire [WIDTH-1  : 0] B1x3;
wire [WIDTH-1  : 0] B2x1;
wire [WIDTH-1  : 0] B2x2;
wire [WIDTH-1  : 0] B2x3;
wire [WIDTH-1  : 0] B3x1;
wire [WIDTH-1  : 0] B3x2;
wire [WIDTH-1  : 0] B3x3; 
wire Clear;

REGISTER # ( .WIDTH(WIDTH) , .ROW(ROW) , .COLOUM(COLOUM)  ) G1 (
      CLK               ,
      RST               ,
      A_IN_ROW_1        ,
      A_IN_ROW_2        ,
      A_IN_ROW_3        ,
      B_IN_COLOUM_1     ,
      B_IN_COLOUM_2     ,
      B_IN_COLOUM_3     ,
      A_OUT_ROW_1       ,
      A_OUT_ROW_2       ,
      A_OUT_ROW_3       ,
      B_OUT_COLOUM_1    ,  
      B_OUT_COLOUM_2    , 
      B_OUT_COLOUM_3    ,
      Clear       
);

PROCESS_ELEMENT # ( .WIDTH(WIDTH) ) G2  ( CLK , RST , Clear , A_OUT_ROW_1 , B_OUT_COLOUM_1 , A1x1 , B1x1 , OUT_1x1) ;
PROCESS_ELEMENT # ( .WIDTH(WIDTH) ) G3  ( CLK , RST , Clear , A1x1, B_OUT_COLOUM_2 , A1x2 , B1x2 , OUT_1x2) ;
PROCESS_ELEMENT # ( .WIDTH(WIDTH) ) G4  ( CLK , RST , Clear , A1x2, B_OUT_COLOUM_3 , A1x3 , B1x3 , OUT_1x3) ;
PROCESS_ELEMENT # ( .WIDTH(WIDTH) ) G5  ( CLK , RST , Clear , A_OUT_ROW_2 , B1x1, A2x1 , B2x1 , OUT_2x1) ;
PROCESS_ELEMENT # ( .WIDTH(WIDTH) ) G6  ( CLK , RST , Clear , A2x1, B1x2, A2x2 , B2x2 , OUT_2x2) ;
PROCESS_ELEMENT # ( .WIDTH(WIDTH) ) G7  ( CLK , RST , Clear , A2x2, B1x3, A2x3 , B2x3 , OUT_2x3) ;
PROCESS_ELEMENT # ( .WIDTH(WIDTH) ) G8  ( CLK , RST , Clear , A_OUT_ROW_3 , B2x1, A3x1 , B3x1 , OUT_3x1) ;
PROCESS_ELEMENT # ( .WIDTH(WIDTH) ) G9  ( CLK , RST , Clear , A3x1, B2x2, A3x2 , B3x2 , OUT_3x2) ;
PROCESS_ELEMENT # ( .WIDTH(WIDTH) ) G10 ( CLK , RST , Clear , A3x2, B2x3, A3x3 , B3x3 , OUT_3x3) ;
endmodule

module SYSTOLIC_ARRAY_TB ();
  parameter WIDTH_SUM = 8;
  parameter WIDTH = 12;
  reg CLK;
  reg RST;
  reg [WIDTH-1:0] A_ROW1;
  reg [WIDTH-1:0] A_ROW2;
  reg [WIDTH-1:0] A_ROW3;
  reg [WIDTH-1:0] B_COLOUM1;
  reg [WIDTH-1:0] B_COLOUM2;
  reg [WIDTH-1:0] B_COLOUM3;
  wire [WIDTH_SUM:0] C_OUT_1x1;
  wire [WIDTH_SUM:0] C_OUT_1x2;
  wire [WIDTH_SUM:0] C_OUT_1x3;
  wire [WIDTH_SUM:0] C_OUT_2x1;
  wire [WIDTH_SUM:0] C_OUT_2x2;
  wire [WIDTH_SUM:0] C_OUT_2x3;
  wire [WIDTH_SUM:0] C_OUT_3x1;
  wire [WIDTH_SUM:0] C_OUT_3x2;
  wire [WIDTH_SUM:0] C_OUT_3x3;

  SYSTOLIC_ARRAY DUT (
    CLK,
    RST,
    A_ROW1,
    A_ROW2,
    A_ROW3,
    B_COLOUM1,
    B_COLOUM2,
    B_COLOUM3,
    C_OUT_1x1,
    C_OUT_1x2,
    C_OUT_1x3,
    C_OUT_2x1,
    C_OUT_2x2,
    C_OUT_2x3,
    C_OUT_3x1,
    C_OUT_3x2,
    C_OUT_3x3
  );

  always #5 CLK = ~CLK;

  initial begin
    CLK = 1'b0;
    RST = 1'b1;
    A_ROW1 = 12'b0001_0010_0011;
    A_ROW2 = 12'b0100_0101_0110;
    A_ROW3 = 12'b0111_1000_1001;
    B_COLOUM1 = 12'b0001_0100_0111;
    B_COLOUM2 = 12'b0010_0101_1000;
    B_COLOUM3 = 12'b0011_0110_1001;
    #10 RST = 1'b0;
    #100 RST = 1'b1;
    A_ROW1 = 12'b0111_0010_0010;
    A_ROW2 = 12'b0100_0000_1001;
    A_ROW3 = 12'b0111_1000_1001;
    B_COLOUM1 = 12'b1010_0100_0111;
    B_COLOUM2 = 12'b0010_0101_1000;
    B_COLOUM3 = 12'b0100_1011_0010;
    #10 RST = 1'b0;
    #100;
  end
endmodule

