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
	eq => 2
	neq => 3
	ls => 4
	greq => 5
	gr => 6
	lseq => 7

	d0 => 8
	nd0 => 9
	d1 => 10
	nd1 => 11
	d2 => 12
	nd2 => 13
	d3 => 14
	nd3 => 15
}

#ruledef
{
	; Immediate Load
	ld {value: u8} => 0x00 @ value
	
	; Address Load
	ld [{address: u12}] => 0x8 @ address
	
	; Immediate Store
	st [{address: u12}] => 0x1 @ address

	; Address Store
	st [[{address: u12}]] => 0x9 @ address
	
	; Immediate Add
	add {value: u8} => 0x20 @ value
	
	; Address Add
	add [{address: u12}] => 0xA @ address
	
	; Immediate Nand
	nand {value: u8} => 0x30 @ value
	
	; Address Nand
	nand [{address: u12}] => 0xB @ address

	; Compare with Immediate
	cmp {f: flag},{value: u8} => {
		0x4 @ f`4 @ value
	}

	; Compare with ALU
	cmp {f: flag} => {
		0xC @ f`4
	}
	
	; Address Store Program Counter
	spc [{address: u12}] => 0xD @ address
	
	; Immediate Jump
	jp {address: u12} => 0x6 @ address
	
	; Address Jump
	jp [{address: u12}] => 0xE @ address
	
	; Immediate Conditional Jump
	jpc {address: u12} => 0x7 @ address
	
	; Address Conditional Jump
	jpc [{address: u12}] => 0xF @ address
}