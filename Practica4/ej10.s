.data
cadena: .asciiz "daddi";"adbdcdedfdgdhdid"
CANT: .word 0
car: .asciiz "d"

.code
dadd r3, r0, r0;desplazamiento en las tabla
lbu r1, car(r0)
dadd r5, r0, r0
loop: lbu r2, cadena(r3)
nop
beq r2, r1, escar
finloop: daddi r3, r3, 1
bnez r2, loop
fin: sd r5, CANT(r0)
halt


escar: daddi r5, r5, 1
j finloop