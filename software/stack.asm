#include "b8.asm"
spc [0xFFE]
LD [num]
ADD 1
JPC freeze
ST [num]
JP [0xFFE]

freeze:
JP freeze

num:
#d8 0