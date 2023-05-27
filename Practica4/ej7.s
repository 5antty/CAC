.data
tabla: .word 10, 1, 14, 3, 2, 58, 18, 7, 12, 11
CANT: .word 0
long: .word 10
X: .word 9
res: .word 0

.code
ld r1, long(r0)
dadd r7, r0, r0;desplazamiento en las tabla
ld r3, X(r0)
dadd r5, r0, r0
loop: dadd r4, r0, r0;resultado de la comparacion
ld r2, tabla(r7)
daddi r1, r1, -1
slt r4, r3, r2
nop
bnez r4, mayor
finloop: daddi r7, r7, 8
bnez r1, loop
fin: sd r5, CANT(r0)
halt


mayor: daddi r5, r5, 1
sd r4, res(r7)
j finloop