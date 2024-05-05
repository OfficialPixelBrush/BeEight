#bankdef b8
{
    #addr 0x00
    #size 0x100
    #outp 0
    #fill
	#labelalign 128
}
; lower three bits for register
; if last bit is set, then special function 
# ruledef register
{
	;registers
	; none => 0x0
	m => 0x1 ; memory
    pb => 0x2 ; primary buffer
    sb => 0x3 ; secondary buffer
    a => 0x4 ; accumulator
    alu => 0x5 ; alu (output determined by instruction)
    pc => 0x6 ; program counter
    pcs => 0x7 ; program counter storage
	; 0x8 reset instruction counter
	; 0x9 output upper nybble of pcs into memory
	pbp => 0xA; 0xA primary buffer, preserve instruction
	; 0xB 
	; 0xC
	cf => 0xD ; 0xD update conditional flag
	; 0xE increment pc
	; 0xF 
}

#ruledef
{
    ; 0 output ro, input ri
	; osb outputs boths pb and sb onto 12-Bit DB
    o{ro: register} i{ri:register}=> ro`4 @ ri`4
	o{ro: register} =>  ro`4 @ 0`4
	i{ri: register} =>  0`4 @ ri`4
	; increment pc
	inc => 0x0`4 @ 0xE`4
	; reset instruction counter
	nxt => 0x8`4 @ 0x0`4
	; output upper nybble of pcs into memory
	pcsu => 0x7`4 @ 0x9`4
}

; Load from Immediate
ldImm:
om ipb
inc
om ia
inc
nxt ; <- Interrupt opportunity?

; Store to Address
stImm:
om ipb
inc
om isb
inc
opc ipcs
osb ipc
oa im
opcs ipc
nxt

; Add Immediate
addImm:
om ipb
inc
om isb
inc
osb ialu
oalu ia
nxt

; Nand Immediate (SL/SR)
nandImm:
om ipb
inc
ialu
oalu ia
nxt

; Compare A with Immediate
cmpImm:
om ipb
inc
om icf
inc
nxt

; Store Program Counter
spcImm:
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

; Jump to immediate
jpImm:
om ipb
inc
om isb
osb ipc
nxt

; Jump to immediate Conditional
jpcImm:
om ipb
inc
om isb
inc
osb ipc
nxt

; Load from Address
ldAddr:
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
stAddr:
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
oa im
opcs ipc
nxt

; Address Add
addAddr:
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
nandAddr:
om ipb
inc
om isb
inc
om isb
osb ialu
oalu ia
nxt

; Compare A with ALU
cmpAddr:
om ipb
oalu icf
inc
nxt

; Store Program Counter via Address
spcAddr:
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
jpAddr:
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
jpcAddr:
om ipb
inc
om isb
osb ipc
om ipbp
inc
om isb
osb ipc
nxt