module ALU_Design(A, B, F, Y, V, Z);
input[31:0] A, B;
input[2:0] F;
output reg[31:0] Y;
output reg V;
output Z;
wire[31:0] S, BB;

assign BB = F[2] ? ! B :B;
assign S = A + BB +F[2];

always @ (*)
case (F[1:0])
2'b00: Y <= A & BB;
2'b01: Y <= A | BB;
2'B10: Y <= S;
2'B11: Y <= S[31];
endcase

assign Z = (Y == 32'b0);

always @ (*)

case (F[2])

1'b0: V <= (A[31] & B[31] & ~S[31]) | (~A[31] & ~B[31] & S[31]);
1'b1: V <= (~A[31] & B[31] & S[31]) | (A[31] & ~B[31] & ~S[31]);
default: V <= 1'b0;
endcase
endmodule