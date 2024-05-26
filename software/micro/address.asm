; Load from Address
#align 128
om ipb
inc
om isb
inc
opc ipcs
osb ipc
om ia
opcs ipc
nxt

; Store via Address
#align 128
om ipb
inc
om isb
inc
opc ipcs
osb ipc
oa im
opcs ipc
nxt

; Address Add
#align 128
om ipb
inc
om isb
inc
opc ipcs
osb ipc
om isb
osb ialu
oalu ia
opcs ipc
nxt

; Address Nand (NAND Operand)
#align 128
om ipb
inc
om isb
inc
om isb
osb ialu
oalu ia
nxt

; Compare A with ALU
#align 128
om ipb
oalu icf
inc
nxt

; Store Program Counter via Address
#align 128
om ipb
inc
om isb
inc
opc ipcs
osb ipc
om ipbp
inc
om isb
osb ipc
pcsu
inc
opcs im
opcs ipc
nxt

; Jump via Address
#align 128
om ipb
inc
om isb
osb ipc
om ipbp
inc
om isb
osb ipc
nxt

; Conditional Jump via Address
#align 128
om ipb
inc
om isb
osb ipc
om ipbp
inc
om isb
osb ipc
nxt