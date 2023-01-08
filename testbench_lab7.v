module testVector();
reg clk, reset;
reg[31:0] A, B;
reg[2:0] F;
wire [31:0] Y;
reg[31:0] result;
wire V, Z;
reg overflow, zero;
reg [31:0] vectornum, errors;
reg[100:0] testvectors[10000:0];

ALU_Design dut(A, B, F, Y, V,Z);

always
begin
clk = 1; #5; clk = 0; #10;
end

initial
begin

$readmemb("testVector.tv", testvectors);
vectornum = 0; errors = 0;
reset = 1; #27; reset = 0;
end

always @(posedge clk)
begin
#1; {A, B, F, overflow, zero, result} = testvectors[vectornum];
end

always @(negedge clk)
if(~reset) begin
if(result !== Y) begin
$display("result Error: inputs = %b", {Y});
$display("outputs = %b (%b expected)", Y, result);
errors = errors + 1;
end

if(zero !== Z) begin
$display("result Error: inputs = %b", {Z});
$display("outputs = %b (%b expected)", Z, zero);
errors = errors + 1;
end

if(overflow !== V) begin
$display("result Error: inputs = %b", {V});
$display("outputs = %b (%b expected)", V, overflow);
errors = errors + 1;
end

vectornum = vectornum + 1;
if(testvectors[vectornum] === 100'bx) begin
$display("%d tests completed with %d errors", vectornum, errors);
$finish;
end
end

endmodule