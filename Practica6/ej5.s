.data
CONTROL: .word32 0x10000
DATA: .word32 0x10008
base: .double 0
exponente: .word 0
uno: .double 1
.code
;Ingreso de base y exponente
daddi $a0, $0, base
jal ingreso
daddi $a0, $0, exponente
jal ingreso
;Llamada a subrutina a_la_potencia con los valores ingresados por teclado
ld $a0, base($0)
ld $a1, exponente($0)
jal a_la_potencia

;Muestra del resultado por pantalla
lwu $t0, DATA($0)
sd $v0, 0($t0)
lwu $t1, CONTROL($0)
daddi $t2, $0, 3
sd $t2, 0($t1)
halt

ingreso: lwu $t0, CONTROL($0)
daddi $t1, $0, 8
sd $t1, 0($t0)
lwu $t0, DATA($0)
ld $t1, 0($t0)
sd $t1, 0($a0)
jr $ra


a_la_potencia: l.d f1, uno($0)
mtc1 $a0, f2
lazo: 
daddi $a1, $a1, -1
mul.d f1, f1, f2
bnez $a1, lazo
terminar: mfc1 $v0, f1
jr $ra