#include <stdio.h>
#include <stdlib.h>
#define MEMSIZE 1 << 12
typedef unsigned char byte;
typedef unsigned short word;

#define printCurrentState 1 << 0
#define printExecInst     1 << 1
#define printChanges 	  1 << 2

byte INTMEM[MEMSIZE] = {};

// Internal Vars
byte mem[MEMSIZE];
int maxCycle = -1;
int currentCycle = 0;
int debugOutput = 0;

// Regs
byte A = 0;
word PC = 0;
byte conditionalFlag = 0;

// Old Regs
byte oldA = 0;
word oldPC = 0;
byte oldConditionalFlag = 0;

// Internal magics
byte inst = 0x0;
word immediate = 0x00;
byte primaryBuffer, secondaryBuffer = 0x0;
byte jumped = 0;

int printIndent() {
	if (debugOutput & ~printChanges) {
		printf("\t\t");
	}
}

word twoBytesToWord(byte first, byte second) {
	word value;
	value = (first & 0x0F) << 8;
	value |= second;
	return value;
}

int main(int argc, char *argv[]) {
	FILE *fptr;
	
	// Argument Handling
	if (argc > 1) {
		// Get the file
		if ((fptr = fopen(argv[1],"rb")) == NULL){
			printf("Error! opening file");

			// Program exits if the file pointer returns NULL.
			return 1;
		}
		//while()
		fread(&mem, sizeof(byte), MEMSIZE, fptr); 
		fclose(fptr);

		if (argc > 2) {
			debugOutput = atoi(argv[2]);
		}

		if (argc > 3) {
			// Stop after # of cycles
			maxCycle = atoi(argv[3]);
		}
	} else {
		for (int i = 0; i < MEMSIZE; i++) {
			mem[i] = INTMEM[i];
		}
	}
	
	while((currentCycle < maxCycle) || (maxCycle == -1)) {
		// Big Endian :p
		inst = (mem[PC] & 0xF0) >> 4;
		immediate = twoBytesToWord(mem[PC], mem[PC+1]);

		//printf("A:%X, B: %X | PC:%02X\n",A,B,PC);
		if (debugOutput & printCurrentState) {
			printf("Inst: %X, immediate: %03X | A:%X, Cond:%X | PC:%03X\n", inst,immediate,A,conditionalFlag,PC);
		}

		if (inst & 0b1000) {
			// Address Mode
			primaryBuffer = mem[immediate];
			secondaryBuffer = mem[immediate];
		} else {
			// Immediate Mode
			primaryBuffer = immediate & 0xFF;
			secondaryBuffer = 0x00;
		}

		switch(inst & 0b0111) {
			case 0:
				// LD
				A = primaryBuffer;
				break;
			case 1:
				// ST
				mem[immediate] = A;
				break;
			case 2:
				// ADD
				A = A+primaryBuffer;
				break;
			case 3:
				// NAND
				A = ~(A & primaryBuffer);
				break;
			case 4:
				// JP
				PC = twoBytesToWord(primaryBuffer, secondaryBuffer);
				break;
			case 5:
				// STP
				mem[twoBytesToWord(primaryBuffer,secondaryBuffer)] = PC >> 8;
				mem[twoBytesToWord(primaryBuffer,secondaryBuffer)+1] = PC & 0xFF;
				break;
			case 6:
				// JPC
				if (conditionalFlag) {
					PC = twoBytesToWord(primaryBuffer, secondaryBuffer);
				}
			case 7:
				// CMP
				// TODO
				break;
		}
		// Limit Registers to intended Range
		A         = A          &  0xFF;
		PC        = PC         & 0xFFF;
		conditionalFlag = conditionalFlag  & 0x01;
		// Print changes
		if (debugOutput & printChanges) {
			if (A != oldA) {
				printIndent();
				printf("A:\t%01X -> %01X\n", oldA, A);
			}
			if (PC != oldPC) {
				printIndent();
				printf("PC:\t%02X -> %02X\n", oldPC, PC);
			}
			if (conditionalFlag != oldConditionalFlag) {
				printIndent();
				printf("Cond:\t%d -> %d\n", oldConditionalFlag, conditionalFlag);
			}
		}

		if (!jumped) {
			PC+=2;
		} else {
			jumped = 0;
		}
		oldA = A;
		oldPC = PC;
		oldConditionalFlag = conditionalFlag;
		currentCycle++;
	}
	return 0;
}