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
}

#ruledef
{
	; Immediate Load
	ld {value: u8} => 0x00 @ value

	; Pointed Load
	ld [idx] => 0x01
	
	; Address Load
	ld [{address: u12}] => 0x8 @ address
	
	; Pointed Store
	st [idx] => 0x11
	
	; Address Store
	st [{address: u12}] => 0x9 @ address
	
	; Immediate Add
	add {value: u8} => 0x20 @ value
	
	; Pointed Add
	add [idx] => 0x21
	
	; Address Add
	add [{address: u12}] => 0xA @ address
	
	; Immediate Bitop (Shift Left)
	SL => {
		0x3`4 @ 0`1 @ 0`3 @ 0x00
	}
	; Immediate Bitop (Shift Right)
	SR => {
		0x3`4 @ 0`1 @ 1`3 @ 0x00
	}
	
	; Immediate Bitop (Nand)
	nand {value: u8} => {
		0x3`4 @ 0`1 @ 2`3 @ value
	}
	
	; Pointed Nand
	nand => {
		0x3`4 @ 1`1 @ 2`3
	}
	
	; Address Nand
	nand [{address: u12}] => {
		0xB`4 @ address
	}

	; Compare with Immediate
	cmp {f: flag},{value: u8} => {
		0x4 @ 0`1 @ f`3 @ value
	}

	; Compare with Pointed
	cmp {f: flag},[idx] => {
		0x4 @ 1`1 @ f`3
	}
	
	; Compare with Pointed(?)
	cmp {f: flag} => {
		0x4 @ 1`1 @ f`3
	}

	; Increment IDX
	inx => {
		0xC0
	}

	; Load IDX
	ldx {address: u12} => 0x50
	
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