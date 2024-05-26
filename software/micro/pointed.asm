; Load from Index
#align 128
om ipb
inc
opc ipcs
oidx ipc
om ia
opcs ipc
nxt

; Store via Index
#align 128
om ipb
inc
opc ipcs
oidx ipc
oa im
opcs ipc
nxt

; Index Add
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

; Index Nand (NAND Operand)
#align 128
om ipb
inc
om isb
inc
om isb
osb ialu
oalu ia
nxt

; Compare A with Index
#align 128
om ipb
oalu icf
inc
nxt

; Store Program Counter (Imm)
#align 128
om ipb
inc
om isb
inc
opc ipcs
osb ipc
pcsu
inc
opcs im
opcs ipc
nxt

; Jump to immediate (Imm)
#align 128
om ipb
inc
om isb
osb ipc
nxt

; Jump to immediate Conditional (Imm)
#align 128
om ipb
inc
om isb
inc
osb ipc
nxt