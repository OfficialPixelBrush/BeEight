#include "b8.asm"
a = 0xFF0
b = 0xFF1
c = 0xFF2
LD 1
ST [a]
LD 0
ST [b]
ST [c]
loop:
	LD [a]
	ST [c]
	ADD [b]
	JPC end
	ST [a]
	LD [c]
	ST [b]
JP loop
end:
JP end