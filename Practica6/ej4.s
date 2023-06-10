.data
CONTROL: .word32 0x10000
DATA: .word32 0x10008
res: .asciiz "Bienvenido", "ERROR"
CLAVE: .asciiz "hola"
CLAVE2: .asciiz "S"
long: .word 4

.code
ld $t1, long($0)
daddi $t2, $0, CLAVE2

loop: jal char
sb $v0, 0($t2)
daddi $t1, $t1, -1
daddi $t2, $t2, 1
bnez $t1, loop

ld $a1, long($0)
daddi $t2, $0, CLAVE
daddi $t3, $0, CLAVE2
loop2: lbu $t4, 0($t2)
lbu $t5, 0($t3)
daddi $t2, $t2, 1
daddi $t3, $t3, 1
daddi $a1, $a1, -1
beq $t4, $t5, loop2
dadd $t6, $0, $0
slti $t6, $a1, 0
beqz $t6, salto
dadd $a0, $0, $0
salto: daddi $a0, $0, res
jal respuesta
halt

char: lwu $s0, CONTROL($0)
daddi $t0, $0, 9
sd $t0, 0($s0)
lwu $t0, DATA($0)
lbu $v0, 0($t0)
jr $ra

respuesta: 
bnez $a1, mostrarError
lwu $t0, DATA($0)
sd $a0, 0($t0)
lwu $t1, CONTROL($0)
daddi $t2, $0, 4
sd $t2, 0($t1)
j finr

mostrarError: daddi $a0, $a0, 12
lwu $t0, DATA($0)
sd $a0, 0($t0)
lwu $t1, CONTROL($0)
daddi $t2, $0, 4
sd $t2, 0($t1)

finr: jr $ra