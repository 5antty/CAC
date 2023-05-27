.data
x: .word 2
y: .word 3
a: .word 2

.code
dadd r4, $zero, $zero
ld r3, a($zero)
ld r1, x($zero)
ld r2, y($zero)

loop: slt r4, $zero, r3
nop
beqz r4, finloop
dadd r1, r1, r2
daddi r3, r3, -1
j loop

finloop: sd r1, x($zero)
sd r3, a($zero)
halt