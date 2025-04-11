module Full_Adder(in1,in2,cin,Sum,cout);
        input in1,in2,cin;
        output Sum,cout;
        wire i_sum;
        wire i_carry1,i_carry2,i_carry3;
  		reg Sum,cout;
  
        assign #2 i_sum=in1 ^ in2;
        assign #1 i_carry1=in1 & in2;
        assign #1 i_carry2=in1 & cin;
        assign #1 i_carry3=in2 & cin;
        assign #2 cout=i_carry1 | i_carry2 | i_carry3;
        assign #4 Sum= i_sum ^ cin;
endmodule

module Full_Adder_N(ra,rb,cin,Sum,Cout);  
  input [7:0] ra;
  input [7:0] rb;
  input cin;
  output [7:0] Sum;
  output Cout;
  wire [8:0] Cinter;
        assign Cinter[0]=cin;
  		
  
        genvar i;
        generate
          for (i=0;i<8;i=i+1)  begin
                  
                  Full_Adder fa_inst(.in1(ra[i]),.in2(rb[i]),.cin(Cinter[i]),.Sum(Sum[i]),.cout(Cinter[i+1]));
                end
        endgenerate
	

  assign Cout=Cinter[8];
  
endmodule


module Adder(TClk,ra,rb,cin,Sum,Cout);
       
        input [31:0] ra;
        input [31:0] rb;
        input cin,TClk;
        output [31:0] Sum;
        output Cout;
  		reg c;
  reg [4:0] c0;
        reg clk;
  		wire c1;
  reg [31:0] Sum;
        reg Cout;
  assign c0[0]=cin;
  reg w;
  
          reg [7:0] in1;
          reg [7:0] in2;
          reg [7:0] sum1;
  Full_Adder_N fa_inst(.ra(in1),.rb(in2),.cin(c),.Sum(sum1),.Cout(c1));
	genvar i;
  always @(posedge TClk) begin
				
    in1=ra[7:0];
    in2=rb[7:0];
                c<=c1;
              	Sum<=Sum<<8 | sum1;
              end
  assign Cout=c;
	
endmodule


// clock period  = critical path (2(for isum)+2(for sum))*8=32
