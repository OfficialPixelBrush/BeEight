#include "b8.asm"
; 32-bit addition
; 3557595339 + 314740451
; = 3872335790
LD [numberOne+3]
ADD [numberTwo+3]
ST [result+3]
LD [numberOne+2]
ADD [numberTwo+2]
ST [result+2]
LD [numberOne+1]
ADD [numberTwo+1]
ST [result+1]
LD [numberOne]
ADD [numberTwo]
ST [result]
stop:
JP stop

numberOne:
#d32 3557595339 
numberTwo:
#d32 314740451
result:
#d32 0