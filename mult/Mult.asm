// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.

	@negativeflag
	M=0 	// set negative-flag to false (=0)
	@R2
	M=0		// reset R2 to 0
	@R0
	D=M; 	// load R0 to D
	@POSITIVE_R0
	D;JGE 	// if D>=0 no need to compute its negative value
	@negativeflag
	M=1 	// set negative-flag to true (=1)
	D=-D 	// flip D to its negative value
(POSITIVE_R0)
	@i
	M=D 	// put positive value of R0 in i
(LOOP)
	@i 		
	D=M
	@NEGATION
	D; JLE	// if i<=0 JMP to NEGATION;
	@R1
	D=M
	@R2
	M=M+D	// add R1 to the summing result in R2
	@i
	M=M-1	// decrease i by 1
	@LOOP
	0;JMP 	// jump to LOOP

(NEGATION)
	@negativeflag
	D=M
	@END
	D;JEQ 	// jump if no negation is needed
	@R2
	M=-M
(END)		// with no infinite loop
	@END
	0;JMP