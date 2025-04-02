module REGISTER # ( parameter WIDTH = 4 , ROW = 3 , COLOUM = 3  ) (
  input wire CLK,
  input wire RST, 
  input wire [(WIDTH*ROW)-1 : 0] A_IN_ROW_1,
  input wire [(WIDTH*ROW)-1 : 0] A_IN_ROW_2,
  input wire [(WIDTH*ROW)-1 : 0] A_IN_ROW_3,
  input wire [(WIDTH*COLOUM)-1 : 0] B_IN_COLOUM_1,
  input wire [(WIDTH*COLOUM)-1 : 0] B_IN_COLOUM_2,
  input wire [(WIDTH*COLOUM)-1 : 0] B_IN_COLOUM_3,
  output reg [WIDTH-1 : 0] A_OUT_ROW_1,
  output reg [WIDTH-1 : 0] A_OUT_ROW_2,
  output reg [WIDTH-1 : 0] A_OUT_ROW_3,
  output reg [WIDTH-1 : 0] B_OUT_COLOUM_1,
  output reg [WIDTH-1 : 0] B_OUT_COLOUM_2,
  output reg [WIDTH-1 : 0] B_OUT_COLOUM_3,
  output reg Clear   
);

parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b011;
parameter S3 = 3'b010;
parameter S4 = 3'b110;
parameter S5 = 3'b100;
parameter final = 3'b101;

reg  [ 2 : 0 ]  CURRENT_STATE;
reg  [ 2 : 0 ]  NEXT_STATE;

always @ ( posedge CLK or posedge RST )
begin
if ( RST )
begin
CURRENT_STATE = S0 ;
end
else
begin
CURRENT_STATE =  NEXT_STATE;
end
end

always @ ( * )
begin 
  case ( CURRENT_STATE )
  S0 : NEXT_STATE =  S1  ;
  S1 : NEXT_STATE =  S2  ;
  S2 : NEXT_STATE =  S3  ;
  S3 : NEXT_STATE =  S4  ;
  S4 : NEXT_STATE =  S5  ;
  S5 : NEXT_STATE =  final;
  final: NEXT_STATE =  final;
  default : NEXT_STATE = S0 ;
  endcase
end

always @ ( posedge CLK or posedge RST )
begin
  case ( CURRENT_STATE )
  S0 :  begin
          A_OUT_ROW_1 = 4'b 0000  ;
          A_OUT_ROW_2 = 4'b 0000  ;
          A_OUT_ROW_3 = 4'b 0000  ;
          B_OUT_COLOUM_1 = 4'b 0000  ;
          B_OUT_COLOUM_2 = 4'b 0000  ;
          B_OUT_COLOUM_3 = 4'b 0000  ;
	  Clear = 1'b1;
        end
    S1 :  begin
          A_OUT_ROW_1     = A_IN_ROW_1 [11:8];
          A_OUT_ROW_2     = 4'b0000;
          A_OUT_ROW_3     = 4'b0000;
          B_OUT_COLOUM_1  = B_IN_COLOUM_1 [11:8] ;
          B_OUT_COLOUM_2  = 4'b0000 ;
          B_OUT_COLOUM_3  = 4'b0000 ;
          Clear = 1'b0;
        end
  S2 :  begin
         A_OUT_ROW_1     = A_IN_ROW_1 [7:4];
         A_OUT_ROW_2     = A_IN_ROW_2 [11:8];
         A_OUT_ROW_3     = 4'b0000;
         B_OUT_COLOUM_1  = B_IN_COLOUM_1 [7:4] ;
         B_OUT_COLOUM_2  = B_IN_COLOUM_2 [11:8] ;
         B_OUT_COLOUM_3  = 4'b0000;
         Clear = 1'b0;
        end
  S3 :  begin   
          A_OUT_ROW_1  = A_IN_ROW_1 [3:0];
	  A_OUT_ROW_2  = A_IN_ROW_2 [7:4];
          A_OUT_ROW_3  = A_IN_ROW_3 [11:8];
          B_OUT_COLOUM_1  = B_IN_COLOUM_1 [3:0] ;
          B_OUT_COLOUM_2  = B_IN_COLOUM_2 [7:4] ;
          B_OUT_COLOUM_3  =  B_IN_COLOUM_3 [11:8];
          Clear = 1'b0;
        end
  S4 :  begin
         A_OUT_ROW_1  = 4'b0000;
	  A_OUT_ROW_2  = A_IN_ROW_2 [3:0];
          A_OUT_ROW_3  = A_IN_ROW_3 [7:4];
          B_OUT_COLOUM_1  = 4'b0000 ;
          B_OUT_COLOUM_2  = B_IN_COLOUM_2 [3:0] ;
          B_OUT_COLOUM_3  =  B_IN_COLOUM_3 [7:4];
          Clear = 1'b0;
        end
  S5 :  begin
          A_OUT_ROW_1  = 4'b0000;
	  A_OUT_ROW_2  = 4'b0000;
          A_OUT_ROW_3  = A_IN_ROW_3 [3:0];
          B_OUT_COLOUM_1  = 4'b0000 ;
          B_OUT_COLOUM_2  = 4'b0000 ;
          B_OUT_COLOUM_3  =  B_IN_COLOUM_3 [3:0];
          Clear = 1'b0;
        end
  final: begin
      A_OUT_ROW_1 = 4'b0000;
      A_OUT_ROW_2 = 4'b0000;
      A_OUT_ROW_3 = 4'b0000;
      B_OUT_COLOUM_1 = 4'b0000;
      B_OUT_COLOUM_2 = 4'b0000;
      B_OUT_COLOUM_3 = 4'b0000;
      Clear = 1'b0;
    end
  default : begin
          A_OUT_ROW_1 = 4'b 0000  ;
          A_OUT_ROW_2 = 4'b 0000  ;
          A_OUT_ROW_3 = 4'b 0000  ;
          B_OUT_COLOUM_1 = 4'b 0000  ;
          B_OUT_COLOUM_2 = 4'b 0000  ;
          B_OUT_COLOUM_3 = 4'b 0000  ;
          Clear = 1'b1;
        end
  endcase
end

endmodule
