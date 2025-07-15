; Escribir otra función cuentaMult4 que toma el mismo array del punto a) y cuenta la cantidad de números que son múltiplos de 4.
;	cuentaMult4(*p,size)
;		cuenta = 0
;		for f=0; f<size; f++
;			if (p[f] es mult4) cuenta++
;		return cuenta

main:
	SET R7, 0xFF	;stack (puntero a la última pos)
	SET R0, p	; donde inicia el array
	SET R1, 0x10	; tamaño total son 16 bits
	SET R4, 0x00	; Se inicializa el contador en 0

	CALL |R7|, cuentaMult4

halt:
	JMP halt


cuentaMult4:
	;Comienzo preservando los registros para no perder sus valores originales:
	PUSH |R7|, R0 
	PUSH |R7|, R1
	PUSH |R7|, R2
	PUSH |R7|, R3
	PUSH |R7|, R5
	PUSH |R7|, R6
       
        
	
		
ciclo:
	SET R2,0x03 ; Màscara para constante 0000 0011 (Necesito que los ùltimos 2 bits sean 1) para que 1 and 0 = 0 y me asegure que es o 1 and 1 = no lo es.
 	SET R3,0X00 ; Nos sirve para confirmar si es mul4, necesitamos que luego del AND R5 sea todos 0´s.
	LOAD R5, [R0]
	SET R6, 0X01
	AND R5,R2 ;Aplico el and bit a bit con mi número original y mi constante
	CMP R5,R3 ; Comparamos para saber si es multiplo de 4 = si el resultado me da 0000 0000 implica que lo es.
	JZ yes_mul4 ;Si es multiplo 4 saltamos a la etiqueta para sumar uno al contador
	;Si no fuera multiplo
next_pos:
	ADD R0, R6; Incremento el puntero para pasar a la siguiente posicion del array
	SUB R1, R6
	CMP R1,R3
	JZ fin_funcion ;Si se recorrio todo, finalmente salta a fin funcion y devuelve el resultado
	JMP ciclo ;Si no recorrio todo el array vuelve a ejecutarse el ciclo

	
yes_mul4:
	ADD R4, R6; Se suma uno a R4 si el número es mul4 
 	JMP next_pos
	
fin_funcion:    
	POP |R7|, R6
	POP |R7|, R5
	POP |R7|, R3
	POP |R7|, R2
	POP |R7|, R1
	POP |R7|, R0	
	
	RET|R7|


p:
DB 0x01
DB 0x02
DB 0x04
DB 0x08
DB 0x03
DB 0x03
DB 0xA1
DB 0xC0
DB 0xFA
DB 0x40
DB 0x55
DB 0xCC
DB 0xBD
DB 0x45
DB 0x9A
DB 0xEE
