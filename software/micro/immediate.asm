; Load from Immediate
#align 128
om ipb
inc
om ia
inc
nxt ; <- Interrupt opportunity?

; Increment Index
#align 128
om ipb
inc
inx
nxt

; Add Immediate
#align 128
om ipb
inc
om isb
inc
osb ialu
oalu ia
nxt

; Nand Immediate (SL/SR)
#align 128
om ipb
inc
ialu
oalu ia
nxt

; Compare A with Immediate
#align 128
om ipb
inc
om icf
inc
nxt

; Load into Index
#align 128
om ipb
inc
om isb
inc
osb iidx
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