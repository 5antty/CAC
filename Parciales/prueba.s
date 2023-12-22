.data
num1: .word 4
num2: .word 5
res: .word 0
.code
ld r1, num1($0)
ld r2, num2($0)
nop
nop
dadd r3, r1, r2
sd r3, res($0)
halt