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
	; --- IMMEDIATE ---
	; Immediate Load
	ld {value: u8} => 0x00 @ value

	; Increment IDX
	inx => {
		0x10
	}
	
	; Immediate Add
	add {value: u8} => 0x20 @ value
	
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

	; Compare with Immediate
	cmp {f: flag},{value: u8} => {
		0x4 @ 0`1 @ f`3 @ value
	}

	; Load into Index
	ldx [{address: u12}] => 0x5 @ address
	
	; Immediate Jump
	jp {address: u12} => 0x6 @ address
	
	; Immediate Conditional Jump
	jpc {address: u12} => 0x7 @ address

	; --- POINTED ---
	; Pointed Load
	ld [idx] => 0x08
	
	; Pointed Store
	st [idx] => 0x18
	
	; Pointed Add
	add [idx] => 0x28
	
	; Pointed Bitop (Shift Left)
	SL => {
		0x3`4 @ 1`1 @ 0`3
	}
	; Pointed Bitop (Shift Right)
	SR => {
		0x3`4 @ 1`1 @ 1`3
	}
	
	; Pointed Nand
	nand => {
		0x3`4 @ 1`1 @ 2`3
	}

	; Compare with Pointed
	cmp {f: flag},[idx] => {
		0x4 @ 1`1 @ f`3
	}
	
	; --- ADDRESS ---
	; Address Load
	ld [{address: u12}] => 0x8 @ address
	
	; Address Store
	st [{address: u12}] => 0x9 @ address
	
	; Address Add
	add [{address: u12}] => 0xA @ address
	
	; Address Nand
	nand [{address: u12}] => {
		0xB`4 @ address
	}
	
	; Store Index
	stx [{address: u12}] => {
		0xC @ address
	}
	
	; Address Store Program Counter
	spc [{address: u12}] => 0xD @ address
	
	; Address Jump
	jp [{address: u12}] => 0xE @ address
	
	; Address Conditional Jump
	jpc [{address: u12}] => 0xF @ address
}