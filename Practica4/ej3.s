.data
A: .word 1
B: .word 6

.code
ld r2, B(r0)
ld r1, A(r0)
dadd r3, r0, r0
loop: daddi r2, r2, -1
daddi r3, r3, 8
dsll r1, r1, 1
sd r1, B(r3)
bnez r2, loop
halt