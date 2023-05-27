.data
n1: .double 9.13
n2: .double 6.58
res1: .double 0.0
res2: .double 0.0
.code
l.d f1, n1(r0)
l.d f2, n2(r0)
add.d f3, f2, f1
mul.d f1, f2, f1
mul.d f4, f2, f1
s.d f3, res1(r0)
s.d f4, res2(r0)
halt

;a) 16 ciclos, 7 instrucciones y CPI 2.286

;b) Se producen 4 atascos por dependencias de datos RAW

;c)Los atascos estructurales que se producen son por las instrucciones de store

;d) Se produce un atasco WAR porque se quiere escribir f1 en la instruccion 