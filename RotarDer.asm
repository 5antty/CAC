org 1000h
num db 10101100b
pos db 7
org 3000h
rotarder: mov ah, 0
mul: add al, al
adc al, 0
dec cl 
cmp cl, 0
jnz mul
ret
org 2000h
mov al, num
mov cl, pos
call rotarder
hlt
end

ROTARDER: CMP CX, 0
JZ FINDER
MOV BX, 7
CALL ROTARIZQ
DEC CX
JMP ROTARDER