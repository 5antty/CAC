.data
tabla: .word 5, 1, 4, 2, 3
M: .word 3
long: .word 5
result: .word 0

.code
lbu $a0, M($zero)
daddi $a1, $0, tabla
ld $a2, long($0)
jal subr
sd $v0, result($0)
halt

subr: dadd $v0, $0, $0
loop: daddi $a2, $a2, -1
ld $t2, 0($a1)
daddi $a1, $a1, 8
beqz $a2, finr
slt $t1, $a0, $t2
nop
beqz $t1, loop
daddi $v0, $v0, 1
j loop
finr: jr $ra