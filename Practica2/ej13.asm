
TIMER EQU 10H
PIC EQU 20H
EOI EQU 20H
N_CLK EQU 10

ORG 40
IP_CLK DW RUT_CLK

ORG 1000H
MIN DB 30H
M DB 30H
  DB ":"
SEG DB 30H
S DB 30H
  DB " "
FIN DB ?

ORG 3000H
RUT_CLK: PUSH AX
        INC S ;Incrementamos los segundos
        CMP S, 3AH ;Si no pasa el 9, reseteamos el timer
        JNZ RESET
        MOV S, 30H ;Lo volvemos a 0
        INC SEG ;Incrementamos los seg
        CMP SEG, 36H ;Si no pasa el 6, reseteamos el timer
        JNZ RESET
        MOV SEG, 30H ;Lo volvemos a 0
        INC   M        ;Incrementamos los minutos
        CMP   M, 3AH   ;Si no pasa el 9, reseteamos el timer
        JNZ   RESET
        MOV   M, 30H   ;Lo volvemos a 0
        INC   MIN       ;Incrementamos los minutos
        CMP   MIN, 36H  ;Si no pasa el 6, reseteamos el timer
        JNZ   RESET
        MOV   MIN,30H
RESET:   CMP S, 30H ;Vemos si pasaron 10 segundos
        JNZ SIGO
        INT 7
SIGO:   MOV AL, 0
        OUT TIMER, AL ;Volvemos el timer a 0
        MOV AL, EOI
        OUT PIC, AL ;Le avisamos al pic que termino la interrupcion
        POP AX
        IRET

ORG 2000H
CLI
MOV AL, 0FDH ; 11111101
OUT PIC+1, AL ; PIC: registro IMR
MOV AL, N_CLK
OUT PIC+5, AL ; PIC: registro INT1
MOV AL, 1
OUT TIMER+1, AL ; TIMER: registro COMP
MOV AL, 0
OUT TIMER, AL ; TIMER: registro CONT
MOV BX, OFFSET MIN
MOV AL, OFFSET FIN-OFFSET MIN
STI
LAZO: JMP LAZO
HLT
END