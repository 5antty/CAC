PIC EQU 20H 
DMA EQU 50H 
N_DMA EQU 20 

ORG 80 
MSJ
IP_DMA DW RUT_DMA 

ORG 1000H 
MSJ DB "FACULTAD DE" 
DB " INFORMATICA" 
FIN DB ? 
NCHAR DB ? 

ORG 1500H 
COPIA DB ? 

; rutina aten interrupción del CDMA 
ORG 3000H 
RUT_DMA: MOV AL, 0FFH ;inhabilita.. 
OUT PIC+1, AL ;interrupc de PIC 
MOV BX, OFFSET COPIA 
MOV AL, NCHAR 
INT 7 
MOV AL, 20H 
OUT PIC, AL ; EOI 
IRET 

ORG 2000H
CLI
MOV AL, N_DMA
OUT PIC+7, AL ; reg INT3 de PIC
MOV AX, OFFSET
OUT DMA, AL ; dir comienzo ..
MOV AL, AH ; del bloque ..
OUT DMA+1, AL ; a transferir
MOV AX, OFFSET FIN-OFFSET MSJ
OUT DMA+2, AL ; cantidad ..
MOV AL, AH ; a ..
OUT DMA+3, AL ; transferir
MOV AX, OFFSET COPIA
OUT DMA+4, AL ; dir destino ..
MOV AL, AH ; del ..
OUT DMA+5, AL ; bloque
MOV AL, 0AH ; CDMA en transfer..
OUT DMA+6, AL ; mem-mem por bloque
MOV AL, 0F7H
OUT PIC+1, AL ; habilita INT3
STI
MOV BX, OFFSET MSJ
MOV AL, OFFSET FIN-OFFSET MSJ
MOV NCHAR, AL
INT 7 ; mensaje original
MOV AL, 7H
OUT DMA+7, AL ; arranque Transfer

INT 0
END
