; lower three bits for register
; if last bit is set, then special function 
# ruledef register
{
	none => 0x0
	m => 0x1 ; memory
    p => 0x2 ; primary buffer
    s => 0x3 ; secondary buffer
    a => 0x4 ; accumulator
    alu => 0x5 ; alu output
    pc => 0x6 ; program counter
    pcs => 0x7 ; program counter storage
	ps => 0x8 ; combined pb and sb
	
	; increment pc
}

#ruledef
{
    ; 0 output ro, input ri
    o{ro: register} i{ri:register}=> 0x0`1 @ ro`3 @ 0x0`1 @ ri`3
}

; Load from Address
#align 4
ldAddr:
om ip
;inc pc
om is
;inc pc
opc ipcs
ops ipc
om ia
opcs ipc