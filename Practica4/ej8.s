.data
num1: .word 2
num2: .word 3

.code
ld r2, num2(r0)
ld r1, num1(r0)
loop: daddi r2, r2, -1
dadd r3, r3, r1
bnez r2, loop
nop
halt