HAND EQU 40H

ORG 1000H
MSJ DB "INGENIERIA E "
DB "INFORMATICA"
FIN DB ?

ORG 2000H
IN AL, HAND+1 ;Guardo en AL el estado del HAND
AND AL, 7FH ; AND entre AL y 0111 1111 (bit mas significativo)
OUT HAND+1, AL
MOV BX, OFFSET MSJ
MOV CL, OFFSET FIN-OFFSET MSJ ;Cantidad de caracteres

POLL: IN AL, HAND+1 ;Guardo en AL el estado del HAND
;Luego de tantas veces como datos tenga el buffer, esto la impresora imprime
AND AL, 1 ;Activo/desactivo bit 0 (0000 0001)
JNZ POLL
MOV AL, [BX]
;Aca estado se pone en 1 cuando el buffer esta lleno
OUT HAND, AL ;Guarda dato en el buffer de la impresora
INC BX
DEC CL
JNZ POLL

INT 0
END
