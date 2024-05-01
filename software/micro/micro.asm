; lower three bits for register
; if last bit is set, then special function 
# ruledef register
{
	;registers
	; none => 0x0
	m => 0x1 ; memory
    p => 0x2 ; primary buffer
    s => 0x3 ; secondary buffer
    a => 0x4 ; accumulator
    alu => 0x5 ; alu (output determined by instruction)
    pc => 0x6 ; program counter
    pcs => 0x7 ; program counter storage
	; 0x8 reset instruction counter
	; 0x9
	; 0xA
	; 0xB
	; 0xC
	; 0xD increment pc
	; 0xF
}

#ruledef
{
    ; 0 output ro, input ri
    o{ro: register} i{ri:register}=> ro`4 @ ri`4
	; reset instruction counter
	nxt => 0x8`4 @ 0x0`4
	; increment pc
	inc => 0xD`4 @ 0x0`4
}

; Load from Immediate
#align 4
ldImm:
om ip
inc
om ia
inc
nxt ; <- Interrupt opportunity?

; Load from Address
#align 4
ldAddr:
om ip
inc
om is
inc
opc ipcs
opcs ipc
om ia
opcs ipc
nxt ; <- Interrupt opportunity?