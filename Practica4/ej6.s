.data
A: .word 4
B: .word 4
C: .word 4
D: .word 0
.code
dadd r3, r0, r0
daddi r5, r0, 24
loop: ld r1, A(r3)
daddi r3, r3, 8
ld r2, A(r3)
daddi r5, r5, -8
beq r1, r2, iguales
bnez r5, loop
j fin
iguales: daddi r4, r4, 1
j loop
fin: sd r4, D(r0)
halt