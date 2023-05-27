.data
peso: .double 78
altura: .double 1.78
imc: .double 0
estado: .word 0
clas: .double 18.5, 25, 30


.code
l.d f1, peso(r0)
l.d f2, altura(r0)
dadd r1, r0, r0 ;Con esto recorro la tabla
dadd r2, r0, r0 ;Con esto seteo la clasificacion
daddi r3, r0, 24 ;inicializacion de 
mul.d f2, f2, f2
div.d f3, f1, f2

loop: l.d f4, clas(r1)
daddi r1, r1, 8
daddi r2, r2, 1
c.lt.d f3, f4
bc1t setClas
bne r1, r3, loop
c.lt.d f4, f3
bc1t setClas

fin: sd r5, estado(r0) 
s.d f5, imc(r0)
halt

setClas: dadd r5, r0, r2
mov.d f5, f3
j fin