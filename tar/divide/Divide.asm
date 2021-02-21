// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Divide.asm

//divides the natural number in R13 by the natural number in R14,  while the result R13/R14 will be stored at R15.
//The remainder should be discarded.

//in the k'th iteration, the algorithm multiplies R14 by 2, and if 2^k * R14 < R13, it multiplies the accumulating answer by 2, until 2^k * R14 >= R13, then returns the outcome
//VARIABLES-
//divider= saves RAM[R14] so we can multiply it. each iteration, k*=2
//divide= saves whats left after k*2 > R13

	@14
	D=M
	@NULLIFY //nullifies the result if RAM[14]=0
	D;JEQ
	@divider
	M=D //sets divider variable as RAM[14]
	@13
	D=M
	@divided
	M=D //sets divided variable as RAM[13]
	@1
	D=A
	@left
	M=D //sets left variable as 1
	@0
	D=A
	@15
	M=D //sets RAM[15] variable as 0
	@13
	D=M
	@14
	D=D-M //checking that RAM[13]>=RAM[14]
	@START
	D;JGT //starting algorithm if RAM[13]>RAM[14]
	@EQUAL
	D;JEQ //sets result to 1 if RAM[13]=RAM[14]
	@NULLIFY 
	D;JLT //nullifies the result if RAM[14]>RAM[13]
(EQUAL)
	@1 //gets here iff RAM[13]=RAM[14]
	D=A
	@15
	M=D
	@END
	0;JMP
(NULLIFY)
	@0 //gets here iff RAM[13]<RAM[14] or RAM[14]=0
	D=A
	@15
	M=D
	@END
	0;JMP
(REVERSE) //if (divider > divided) after divider<<, does divider>>
	@divider
	M=M>>
	@UPDATE_DIV
	0;JMP
(DOUBLE_RES) //doubles left's data if divider * 2 <= divided
	@left 
	M=M<<
	@START
	0;JMP
(START) //the basic loop- doubles divider by 2 and the result accordingly
	@16383
	D=A
	@divider
	D=D-M
	@UPDATE_DIV //if there's positive remainder, updates the divider and divided by subtraction
	D;JLT
	@divider
	M=M<<
	@divided
	D=M
	@divider
	D=D-M
	@DOUBLE_RES //doubles result if divider * 2 <= divided
	D;JGE
	@REVERSE //multiplies divider by half if divider * 2 > divided
	D;JLT
(UPDATE_DIV)
	//updating RAM[15]
	@left
	D=M
	@15
	M=M+D
	@1
	D=A
	@left
	M=D
	@divider //updating divider and divided
	D=M
	@divided
	M=M-D
	@14
	D=M
	@divider
	M=D
	@divided //checking if there is more to calculate
	D=M
	@divider
	D=D-M
	@END
	D;JLT
	@ONE //if divided / RAM[14] = 1, increments RAM[15]
	D;JEQ
	D=D-M
	@START
	D;JGE
	@ONE
	D;JLT
(ONE)
	@left
	D=M
	@15
	M=D+M
	@END
	0;JMP
(END)

