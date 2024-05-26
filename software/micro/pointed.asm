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

; Add via Index
#align 128
om ipb
inc
opc ipcs
oidx ipc
om isb
osb ialu
oalu ia
opcs ipc
nxt

; Bitop via Index (NAND Operand)
#align 128
om ipb
inc
opc ipcs
oidx ipc
om isb
osb ialu
oalu ia
opcs ipc
nxt

; Compare A via Index
#align 128
om ipb
inc
opc ipcs
oidx ipc
om icf
opcs ipc
nxt

; Load into Index
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
osb iidx
opcs ipc
nxt

; Jump to immediate
#align 128
om ipb
inc
om isb
osb ipc
nxt

; Jump to immediate Conditional
#align 128
om ipb
inc
om isb
inc
osb ipc
nxt