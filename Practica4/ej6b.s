.data
A: .word 4
B: .word 4
C: .word 4
D: .word 0
.code
ld r1, A(r0)
ld r2, B(r0)
ld r3, C(r0)
dadd r5, r0, r0
dadd r4, r0, r1
beq r2, r4, iguales
beq r3, r4, iguales
j fin
iguales: daddi r5, r5, 1
j
fin: sd r5, D(r0)
halt