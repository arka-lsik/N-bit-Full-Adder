module TB_Adder();
  reg [31:0] test32_in1;
  reg [31:0] test32_in2;
  reg test32_cin,test_clk;
  reg [31:0] test_in1,test_in2;
  wire [31:0] test32_sum;reg [31:0] test1,test2;
  wire test32_cout;
  Adder dut32(.TClk(test_clk),.ra(test32_in1), .rb(test32_in2), .cin(test32_cin), .Sum(test32_sum), .Cout(test32_cout));

  initial
    begin

      repeat (1000)
        begin
            
            test1=$random;
            test2=$random;
            test_in1=test1;
          	test_in2=test2;
      		    test32_cin = $random % 2;
          repeat(4)
            begin
           		test32_in1 = test_in1 % 256;
        		test32_in2 = test_in2 % 256;
              
              	@(posedge test_clk);
              	test_in1 = test_in1>>8;
              	test_in2 = test_in2>>8;
          		#100;
            end
        end
        #1000 $finish;
    end
  //end of initial block

  initial
    begin
      $monitor($time, " IN1:%b, IN2:%b, CIN:%b, SUM:%b, COUT:%b", test1, test2, test32_cin, test32_sum, test32_cout);
      $dumpfile("fulladderN.vcd");
      $dumpvars;
    end
endmodule
