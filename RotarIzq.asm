ORG 1000h
NUM DB 1
POS DB 3
ORG 3000h
ROTARIZQ: CMP BL, 0
JZ FINIZQ
ADD AL, AL
ADC AL, 0
DEC CL
CMP CL, 0
JNZ ROTARIZQ
FINIZQ: RET

org 2000h
mov al, num
mov cl, pos
call rotarizq
hlt
end