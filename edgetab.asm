if (($%256 != 0))
	org (($/256)*256)+256				; Align to a 256 byte page boundary
endif

m6_edgetab:
	db %01111111
	db %00111111
	db %00011111
	db %00001111
	db %00000111
	db %00000011
	db %00000001
	db %00000000
