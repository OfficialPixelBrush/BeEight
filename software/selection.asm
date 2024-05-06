#include "b8.asm"

JP loopI

size = 31

; 100 bytes of random data!
data:
#d8 0x20, 0x1e, 0x28, 0x20, 0x65, 0xd9, 0x7e, 0xbb, 0xba, 0x57, 0xa3, 0xf2, 0xb3, 0x9c, 0x41, 0xb3, 0x77, 0x20, 0xa0, 0x4e, 0x89, 0x66, 0xa5, 0x30, 0xdc, 0xc5, 0xea, 0x40, 0x2b, 0x40, 0xe9, 0x8f, 0xd4, 0x1f, 0xf9, 0xef, 0x79, 0xf2, 0xd1, 0x87, 0x61, 0x1a, 0x82, 0xfb, 0x3c, 0x49, 0x33, 0xcd, 0x63, 0x4a, 0xc0, 0x26, 0xf8, 0xbb, 0x85, 0x7f, 0x84, 0x92, 0x2f, 0x76, 0x95, 0x6e, 0x95, 0x13, 0x0a, 0xdd, 0x2c, 0x6e, 0xd2, 0x52, 0xc1, 0xcd, 0x32, 0x69, 0xd9, 0xd6, 0xec, 0xb0, 0x39, 0xd1, 0xed, 0x9a, 0x62, 0xe0, 0x5f, 0x8c, 0x44, 0x3e, 0x5b, 0x0a, 0x10, 0x12, 0x71, 0x72, 0x58, 0x06, 0xdc, 0xe4, 0x6f, 0x3f

sorted:
#d8 0xFF
temp:
#d8 0xFF
index:
#d8 0xFF
i:
#d8 0x02
j:
#d8 0x00

loopI:
    LD [i]
    CMP GREQ,size
    JPC finished
    ST [index]
    loopJ:
        LD [i]
        ADD 1
        ST [j]
        CMP GREQ,size
        JPC loopJfinish
        LD [j]
        ST [compare1+1]
        LD [index]
        ST [compare2+1]
        compare1:
        LD [data]
        compare2:
        CMP GREQ,0xFF
        JPC fail
            LD [j]
            ST [index]
        fail:
        LD [j]
        ADD 1
        ST [j]
        JP loopJ
    loopJfinish:
    LD [i]
    ADD 1
    ST [i]
    JP loopI


finished:
    JP finished