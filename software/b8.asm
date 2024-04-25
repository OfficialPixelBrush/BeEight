#once
#bankdef b4
{
    #addr 0x000
    #addr_end 0xfff
    #outp 8 * 0x000
	#bits 8
}

#subruledef flag
{
    0 => 0
    1 => 1
    z => 2
    nz => 3
    eq => 4
    neq => 5
    s => 6
    ns => 7
}

#ruledef
{
	; Immediate Load
	ld {value: u8} => 0x00 @ value
	
	; Address Load
	ld [{address: u12}] => 0x8 @ address
	
	; Address Store
	st [{address: u12}] => 0x9 @ address
	
	; Immediate Add
	add {value: u8} => 0x20 @ value
	
	; Address Add
	add [{address: u12}] => 0xA @ address
	
	; Immediate Nand
	nand {value: u8} => 0x30 @ value
	
	; Address Nand
	nand [{address: u12}] => 0xB @ address
	
	; Immediate Jump
	jp {address: u12} => 0x4 @ address
	
	; Address Jump
	jp [{address: u12}] => 0xC @ address
	
	; Address Store Program Counter
	stp [{address: u12}] => 0xD @ address
	
	; Immediate Conditional Jump
	jpc {address: u12} => 0x6 @ address
	
	; Address Conditional Jump
	jpc [{address: u12}] => 0xE @ address
	
	; Compare Is Condition
	cmp {f: flag}, {value: u8} =>
	{
        assert(f <= 7)
		flagCut = (0`4 | (f & 0x7))
		flagCut`4 @ 0x7`4 @ value`8 
	}
	
	; Compare Is Not Condition
	cmp {f: flag}, {value: u8} =>
	{
        assert(f <= 7)
		flagCut = (0x8`4 | (f & 0x7))
		flagCut`4 @ 0xF`4 @ value`8 
	}
}