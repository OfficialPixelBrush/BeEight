#once
#bankdef b4
{
    #addr 0x0
    #addr_end 0xf
    #outp 4 * 0x0
	#bits 4
}

# ruledef register
{
    pb => 0x0
    sb => 0x1
    a => 0x2
    cond => 0x3
    pc => 0x4
    pcs => 0x5
    aluAdd => 0x6
    aluNand => 0x7
}

#ruledef
{
    ; 0 load
    ld {r: register} => 0x0`1 @ r`3
    ; 1 execute
    ex {r: register} => 0x1`1 @ r`3
}

; Load Immediate
#align 4
ldImm:
ld pb
ex pc
ld sb
ex pc
ld a

; Load from Address
#align 4
ldAddr:
ld pb
ex pc
ld sb
ex pc
; same everywhere
ld pcs ; load pc into pcs
ld pc ; load sb + pb into pc

ld a