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
	pbp => 0x9 ; 0x9 primary buffer, preserve instruction
	; 0xA 
	; 0xB 
	; 0xC 
	; 0xD update conditional flag
	; 0xE increment pc
	pcsu => 0xF ; 0xF upper nybble of PCS
}

#ruledef
{
    ; 0 output ro, input ri
	; osb outputs boths pb and sb onto 12-Bit DB
    o{ro: register} i{ri:register}=> ro`4 @ ri`4
	o{ro: register} =>  ro`4 @ 0`4
	i{ri: register} =>  0`4 @ ri`4
	; update conditional flag
	ucf => 0x0`4 @ 0xD`4
	; increment pc
	inc => 0x0`4 @ 0xE`4
	; reset instruction counter
	nxt => 0x8`4 @ 0x0`4
}

; Load from Immediate
ldImm:
om ipb
inc
om ia
inc
nxt ; <- Interrupt opportunity?

; Store to Immediate???
stImm:
om ipb
inc
oa im
inc
nxt
; Kind of stupid, but it doesn't cost any extra hardware to add :p

; Add Immediate
addImm:
om ipb
inc
om isb
inc
ialu
oalu ia
nxt

; Nand Immediate
nandImm:
om ipb
inc
om isb
inc
ialu
oalu ia
nxt

; Compare Two Byte
cmpImm:
om ipb
inc
ucf
inc
nxt

; Store PC to Immediate???
stpImm:
om ipb
inc
inc
nxt
; Impossible.
; Won't even attempt to add this.
; Why would anyone want this?

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

; Store to Address
stAddr:
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
addAddr:
om ipb
inc
om isb
inc
opc ipcs
osb ipc
om isb
ialu
oalu ia
opcs ipc
nxt

; Address Nand
nandAddr:
om ipb
inc
om isb
inc
opc ipcs
osb ipc
om isb
ialu
oalu ia
opcs ipc
nxt

; Compare One Byte
cmpAddr:
om ipb
ucf
inc
nxt

; Store Program Counter
stpAddr:
om ipb
inc
om isb
inc
opc ipcs
osb ipc
opcs im
inc
opcsu im
opcs ipc
nxt

; Jump via Address
jpAddr:
om ipb
inc
om isb
opc ipcs
opb ipc
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
opc ipcs
opb ipc
om ipbp
inc
om isb
osb ipc
nxt