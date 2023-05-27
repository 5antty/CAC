.data
base: .double 5
altura: .double 4
area: .double 0
dos: .double 2

.code
l.d f1, base(r0)
l.d f2, altura(r0)
l.d f4, dos(r0)
mul.d f3, f1, f2
nop
div.d f5, f3, f4
nop
s.d f5, area(r0)
halt