.data
ca1: .asciiz "hola"
ca2: .asciiz "hola"
long: .word 4
pos: .word 0
result: .word 0

.code
daddi $a1, $0, ca1
daddi $a2, $0, ca2
ld $t1, long($0)
jal subr
sd $v0, pos($0)
bne $v0, $t1, fin
daddi $v1, $0, -1
sd $v1, result($0)
fin: halt

subr: dadd $v0, $0, $0
dadd $t3, $0, $0
loop: lbu $t1, 0($a1)
nop
beqz $t1, finr
daddi $a1, $a1, 1
daddi $t3, $t3, 1
lbu $t2, 0($a2)
nop
daddi $a2, $a2, 1
beq $t1, $t2, loop
dadd $v0, $0, $t3
finr: jr $ra

;long: 
;finr2:jr $ra