.data
tabla: .double 3.2, 4.2, 5.4, 3.2, 5.4, 4.12
long: .word 5
newTabla: .double 0

.code
dadd $a0, $0, $0
dadd $t0, $0, $0
ld $t1, long($0)
loop1:
l.d f1, tabla($t0) ;dato de la tabla original
mov.d f2, f1 ;buffer para comparar si hay numeros duplicados
ld $t3, long($0) ;copio la longitud de la cadena para recorrerla y encontrar las copias
dadd $t2, $0, $0
loop2: 
l.d f3, tabla($t3)
c.eq.d f3, f2
bc1f noAgregar
s.d f3, newTabla($a0)
daddi $a0, $a0, 16
noAgregar: daddi $t3, $t3, -1
bne $t2, $t3, loop2

daddi $t0, $t0, 1
bne $t0, $t1, loop1
halt
