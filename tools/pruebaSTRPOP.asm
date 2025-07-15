
main:
    SET R7, 0xFF ;stack
    SET R1, 0x10	
    SET R2, 0xEA
    PUSH |R7|, R1
    PUSH |R7|, R2
    STRPOP |R7|, 0x30
    STRPOP |R7|, 0x41

halt:
	JMP halt
