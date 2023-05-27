PIC EQU 20H
PIO EQU 30H
N_F10 EQU 10

ORG 40
IP_F10 DW RUT_F10

ORG 1000H
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
OUT PIO, AL ;Manda a PA el resultado de la op anterior
IN AL, PIO ; Vuelco en AL lo que hay en PA
AND AL, 0FDH ;AND con 1111 1011
OUT PIO, AL
RET

RUT_F10: PUSH AX
MOV CL, 1
MOV AL, 0FFH
OUT PIC+1, AL
MOV AL, PIC
OUT PIC, AL ; PIC: registro EOI
POP AX
IRET

;PROGRAMA PRINCIPAL
ORG 2000H
PUSH AX
CALL INI_IMP
POP AX
MOV BX, OFFSET CAR
MOV CL, 0
MOV DL, 0

CLI
MOV AL, 0FEH
OUT PIC+1, AL ; PIC: registro IMR
MOV AL, N_F10
OUT PIC+4, AL ; PIC: registro INT0
STI
LEER: CMP CL, 0
JNZ IMPRIMIR
INT 6 ;Ingreso por teclado un caracter
INC BX
INC DL
JMP LEER
IMPRIMIR: DEC DL
MOV BX, OFFSET CAR
POLL: IN AL, PIO ;Vuelco en AL lo que hay en PA
AND AL, 1; Hago un AND con 0000 0001 PARA SABER 
JNZ POLL; Cuando Z no es 0 vuelve al poll
MOV AL, [BX]; Muevo el caracter a AL
OUT PIO+1, AL; mando a PB el caracter

PUSH AX
CALL PULSO
POP AX

INC BX
DEC DL
JNZ POLL
INT 0
END