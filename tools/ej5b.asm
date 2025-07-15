;Escribir otra función que, haciendo uso de la función desarrollada anteriormente y la instrucción STRPOP, 
;permita encontrar el máximo de un array de numeros enteros positivos en memoria y guardarlo en una dirección de memoria arbitraria.
;
;	guardaMaximoDirección(*p, size, dir)
;		guardaMaximo(*p, size)
;		STRPOP(dir)
;		return

main:
	SET R7, 0xFF		;stack
	SET R0, p		;p
	SET R1, 0x10		;size
	SET R3, 0xD1		;dir
	


	CALL |R7|, guardaMaximoDireccion
	
halt:
	JMP halt
guardaMaximoDireccion:

;Preservamos los registros que vamos a utilizar:
	PUSH |R7|, R4
	PUSH |R7|, R3
	PUSH |R7|, R0
	PUSH |R7|, R1
	PUSH |R7|, R2
	PUSH |R7|, R5
	
	LOAD R6, [R0] ; Acá tenemos nuestro máximo inicial --> el primero de p
	MOV R5, R0 ; El puntero inicial para movernos dentro del array
	ADD R1, R0 ; ME guardo la ultima posición que es  [p+size] nos va servir para saber si terminamos de recorrerlo
        SET R4, 0X01 ;incrementador de posiciones
       
	;Caso base si p es vacío:
	 ADD R5, R4; Sumo 1 más para ver si se pasa
	 CMP R5, R1; Comparo para saber si llegue al final
	 JZ fin
	
	 

loop:
	LOAD R2, [R5] ; Tengo el valor sucesivo para comparar
	CMP R6, R2; ¿R2 será mi nuevo max?
	JC new_max ; Hacemos el salto con carry porque consideramos los casos cuando la cuenta anterior se pasa y hay overflow
	JMP next ;Voy a la etiqueta si el número es igual o si mi numero sigue siendo mayor al que sucesivo.
new_max:
	MOV R6, R2 ; Copiamos el contenido y lo modifica y ahora R3 vale el nuevo valor máximo
	;Despues cambiaré R5 en la siguiente iteración y así hasta llegar al final.
	JMP next

next: ;Como es secuencial se ejecuta si o si para new_max y si no se modifica se hace el salto y se pasa a la siguiente posicion.
	ADD R5, R4
	CMP R1, R5
	
	JZ fin ;Si se recorrio toda salto al final de la funcion y devuelve el resultado
	JMP loop ;Si no recorrio todo el array vuelve a ejecutarse el ciclo
	
fin:

	POP |R7|, R5
	POP |R7|, R2
	POP |R7|, R1
	POP |R7|, R0
	POP |R7|, R3
	POP |R7|, R4
	
	PUSH |R7|, R6 ; Agrego el valor del máximo en la pila,
	;Llamamos a STRPOP:
	DB 0x77
	DB 0xD1
	
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

