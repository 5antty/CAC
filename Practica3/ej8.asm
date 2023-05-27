PIC EQU 20H
HAND EQU 40H
N_HND EQU 10

ORG 40 
IP_HND DW RUT_HND 

ORG 1000H
MSJ DB "UNIVERSIDAD "
DB "NACIONAL DE LA PLATA"
FIN DB ?

ORG 3000H 
;Ingresa a la interrupcion cuando la impresora no esta ocupada
;BIT 0 (BUSY) = 0
RUT_HND: PUSH AX 
MOV AL, [BX] ;Guardo en AL el caracter
OUT HAND, AL ;Mando AL al registro DATO del HAND
INC BX ;Incremento BX para avanzar en la cadena de caracteres
DEC CL ;Decremento la cantidad de caracteres
;Finalizo la interrupcion
MOV AL, 20H 
OUT PIC, AL 
POP AX 
IRET 

ORG 2000H
MOV BX, OFFSET MSJ
MOV CL, OFFSET FIN-OFFSET MSJ
CLI
MOV AL, 0FBH ;Pongo en AL 1111 1011 (enmascaro todos menos el bit para HAND)
OUT PIC+1, AL ;Mando al IMR la mascara anterior
MOV AL, N_HND ;Paso a AL la posicion del vector de interrupcion
OUT PIC+6, AL ; guardo la posicion del vector de interrupcion en registro INT2 del PIC
MOV AL, 80H ;Muevo a AL 1000 0000
OUT HAND+1, AL ;Guardo AL en reg Estado del HAND
;Esto hace que se habiliten el HAND por interrupcion
STI
;Al toque voy a la interrupcion
;Cuando se llena el buffer de la impresora empieza el lazo
;El lazo se hace cuando la impresora tiene BUSY = 1
LAZO: CMP CL, 0 
JNZ LAZO
IN AL, HAND+1 ;Paso a AL el estado del HAND
AND AL, 7FH ; Hago un AND con (0111 1111)
;Vuelvo el bit 7 a 0, es decir desactivo las interrupciones
OUT HAND+1, AL

INT 0
END
