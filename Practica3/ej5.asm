PIO EQU 30H
ORG 1000H
NUM_CAR DB 5
CAR DB ?
; SUBRUTINA DE INICIALIZACION 
; PIO PARA IMPRESORA 
ORG 3000H 
INI_IMP: MOV AL, 0FDH ;pone en AL 1111 1101
OUT PIO+2, AL ;Manda al registro CA lo que hay en AL
MOV AL, 0 
OUT PIO+3, AL ;Pone en 0 el registro CB 
IN AL, PIO ;Vuelca en AL lo que habia en PA
AND AL, 0FDH ; Hace un AND entre PA y 1111 1101
OUT PIO, AL; El resultado anterior lo manda a PA
RET

; SUBRUTINA DE GENERACIÓN
; DE PULSO 'STROBE'
ORG 1700H
PULSO: IN AL, PIO ;AL obtiene lo que habia en PA
OR AL, 02H ;Hace un OR entre PA y 0000 0010
;Con esto le pongo si o si el bit 1 (segundo) en 1
;activo STROBE
OUT PIO, AL ;Manda a PA el resultado de la op anterior
;aca guardo caracter en el buffer de la impresora
IN AL, PIO ; Vuelco en AL lo que hay en PA
AND AL, 0FDH ;AND con 1111 1011
OUT PIO, AL
;En teoria aca imprime
RET

;PROGRAMA PRINCIPAL
ORG 2000H
PUSH AX
CALL INI_IMP
POP AX
MOV BX, OFFSET CAR
MOV CL, NUM_CAR
LAZO: INT 6 ;Ingreso por teclado un caracter
POLL: IN AL, PIO ;Vuelco en AL lo que hay en PA
AND AL, 1; Hago un AND con 0000 0001 PARA SABER 
JNZ POLL; Cuando Z no es 0 vuelve al poll
MOV AL, [BX]; Muevo el caracter a AL
OUT PIO+1, AL; mando a PB el caracter
PUSH AX
CALL PULSO
POP AX
DEC CL ; Decremento el numero de caracteres
JNZ LAZO
INT 0
END