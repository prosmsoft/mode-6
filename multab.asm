if (($%256 != 0))
	org (($/256)*256)+256				; Align to a 256 byte page boundary
endif

m6_multab:
	db 0, 0, 1, 2, 4, 6, 9, 12, 16, 20
	db 25, 30, 36, 42, 49, 56, 64, 72, 81, 90
	db 100, 110, 121, 132, 144, 156, 169, 182, 196, 210
	db 225, 240, 0, 16, 33, 50, 68, 86, 105, 124
	db 144, 164, 185, 206, 228, 250, 17, 40, 64, 88
	db 113, 138, 164, 190, 217, 244, 16, 44, 73, 102
	db 132, 162, 193, 224, 0, 32, 65, 98, 132, 166
	db 201, 236, 16, 52, 89, 126, 164, 202, 241, 24
	db 64, 104, 145, 186, 228, 14, 57, 100, 144, 188
	db 233, 22, 68, 114, 161, 208, 0, 48, 97, 146
	db 196, 246, 41, 92, 144, 196, 249, 46, 100, 154
	db 209, 8, 64, 120, 177, 234, 36, 94, 153, 212
	db 16, 76, 137, 198, 4, 66, 129, 192
	   
	db 0, 192, 129, 66, 4, 198, 137, 76, 16, 212
	db 153, 94, 36, 234, 177, 120, 64, 8, 209, 154
	db 100, 46, 249, 196, 144, 92, 41, 246, 196, 146
	db 97, 48, 0, 208, 161, 114, 68, 22, 233, 188
	db 144, 100, 57, 14, 228, 186, 145, 104, 64, 24
	db 241, 202, 164, 126, 89, 52, 16, 236, 201, 166
	db 132, 98, 65, 32, 0, 224, 193, 162, 132, 102
	db 73, 44, 16, 244, 217, 190, 164, 138, 113, 88
	db 64, 40, 17, 250, 228, 206, 185, 164, 144, 124
	db 105, 86, 68, 50, 33, 16, 0, 240, 225, 210
	db 196, 182, 169, 156, 144, 132, 121, 110, 100, 90
	db 81, 72, 64, 56, 49, 42, 36, 30, 25, 20
	db 16, 12, 9, 6, 4, 2, 1, 0
	   
	db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db 0, 0, 1, 1, 1, 1, 1, 1, 1, 1
	db 1, 1, 1, 1, 1, 1, 2, 2, 2, 2
	db 2, 2, 2, 2, 2, 2, 3, 3, 3, 3
	db 3, 3, 3, 3, 4, 4, 4, 4, 4, 4
	db 4, 4, 5, 5, 5, 5, 5, 5, 5, 6
	db 6, 6, 6, 6, 6, 7, 7, 7, 7, 7
	db 7, 8, 8, 8, 8, 8, 9, 9, 9, 9
	db 9, 9, 10, 10, 10, 10, 10, 11, 11, 11
	db 11, 12, 12, 12, 12, 12, 13, 13, 13, 13
	db 14, 14, 14, 14, 15, 15, 15, 15
	   
	db 16, 15, 15, 15, 15, 14, 14, 14, 14, 13
	db 13, 13, 13, 12, 12, 12, 12, 12, 11, 11
	db 11, 11, 10, 10, 10, 10, 10, 9, 9, 9
	db 9, 9, 9, 8, 8, 8, 8, 8, 7, 7
	db 7, 7, 7, 7, 6, 6, 6, 6, 6, 6
	db 5, 5, 5, 5, 5, 5, 5, 4, 4, 4
	db 4, 4, 4, 4, 4, 3, 3, 3, 3, 3
	db 3, 3, 3, 2, 2, 2, 2, 2, 2, 2
	db 2, 2, 2, 1, 1, 1, 1, 1, 1, 1
	db 1, 1, 1, 1, 1, 1, 1, 0, 0, 0
	db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db 0, 0, 0, 0, 0, 0, 0, 0
