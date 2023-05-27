.data
valor: .word 4
result: .word 0
.text
daddi $sp, $0, 0x400 ; Inicializa el puntero al tope de la pila (1)
ld $a0, valor($0)
jal factorial
sd $v0, result($0)
halt

factorial: daddi $sp, $sp, -8
daddi $s0, $0, 1
sd $ra, 0($sp)
beq $s0, $a0, esUno

daddi $sp, $sp, -8
sd $a0, 0($sp)
daddi $a0, $a0, -1

jal factorial

ld $a0, 0($sp)
daddi $sp, $sp, 8
dmul $v0, $v0, $a0
j terminar
esUno: daddi $v0, $0, 1
terminar: ld $ra, 0($sp)
ld $a0, 8($sp)
daddi $sp, $sp, 8
jr $ra