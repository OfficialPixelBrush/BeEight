#bankdef b8
{
    #addr 0x00
    #size 0x200
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
	; 0x9 output upper nybble of internal databus into memory
	pbp => 0xA; 0xA primary buffer, preserve instruction
	; 0xB 
	idx => 0xC ; 0xC index register
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
	; increment idx
	inx => 0xC`4 @ 0xC`4
	; reset instruction counter
	nxt => 0x8`4 @ 0x8`4
	; output upper nybble of pcs into memory
	dbu => 0x7`4 @ 0x9`4
}

#include "immediate.asm"
#include "address.asm"
#include "pointed.asm"
#include "address.asm"