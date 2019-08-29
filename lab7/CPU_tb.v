module CPUwithDATAPATH_test;
reg reset;
reg clk;

wire tsel, execb, incp;
wire [15:0] IRout, sximm8, sximm5, mdata;
wire [2:0] opcode, writenum, readnum, status, cond;
wire [1:0] op, nsel, vsel, shift, ALUop;
wire loadir, loada, loadb, loadc,loads, asel, bsel, write, msel, mwrite;
wire [15:0] value0, value1, value2, value3, value4, value5;
  

 INSTRUCTIONDECODER DUTIT( .IN(IRout) ,.nsel(nsel), .opcode(opcode), .op(op), .writenum(writenum), .readnum(readnum), .shift(shift), .sximm8(sximm8), .sximm5(sximm5),
	 .ALUop(ALUop), .cond(cond));                
  CPU DUTCPU (.clk(clk),.reset(reset), .opcode(opcode), .op(op), .loadir(loadir), .loada(loada), .loadb(loadb), .loadc(loadc),.loads(loads),  .asel(asel),
	 .bsel(bsel), .write(write), .nsel(nsel), .vsel(vsel), .msel(msel), .mwrite(mwrite), .execb(execb), .incp(incp), .tsel(tsel), .cond(cond));
  datapath DUTDP ( .clk         (clk), // recall from Lab 4 that KEY0 is 1 when NOT pushed

                // register operand fetch stage
                .readnum     (readnum),
                .vsel        (vsel),
                .loada       (loada),
                .loadb       (loadb),

                // computation stage (sometimes called "execute")
                .shift       (shift),
                .asel        (asel),
                .bsel        (bsel),
                .ALUop       (ALUop),
                .loadc       (loadc),
                .loads       (loads),

                // set when "writing back" to register file
                .writenum    (writenum),
                .write       (write),  
                .mwrite      (mwrite),
      	        .loadir      (loadir),
		.reset       (reset),
		.msel        (msel),
		.sximm8      (sximm8),
		.sximm5      (sximm5),

                // outputs
                // .status      (LEDR[9]),
		.status        (status),           
		.IRout       (IRout),
		.mdata       (mdata),
		.value0	     (value0),
		.value1      (value1), 
		.value2      (value2), 
		.value3      (value3), 
		.value4      (value4), 
		.value5      (value5),
		.tsel        (tsel),
		.execb       (execb),
		.incp        (incp),
		.cond        (cond)
);


initial begin
    //setting the clock to change every 5 units
clk=0; #5;
forever begin
clk=1; #5;
clk=0; #5;
end
end

initial begin
#10 reset = 1'b1;
// #100 reset=1'b1;
#10;
reset =1'b0;
#2000;
$display ("%b,%b,%b,%b,%b,%b," ,value0, value1, value2,value3,value4,value5);
$stop;
end
endmodule



