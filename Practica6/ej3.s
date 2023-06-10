.data
CONTROL: .word32 0x10000
DATA: .word32 0x10008

.code 
jal ingreso
dadd $a1, $0, $v0
jal ingreso
dadd $a0, $0, $v0
jal resultado
halt

ingreso: lwu $s0, CONTROL($0)
daddi $t0, $0, 9 ;funcion 8 es para leer un numero por terminal
sd $t0, 0($s0)
lwu $s1, DATA($0)
lbu $t0, 0($s1)
dadd $t2, $0, $0
;daddi $t1, $t0, 48
slti $t2, $t0, 58
beqz $t2, finr
;verificacion
dadd $v0, $0, $t0
finr: jr $ra

resultado:
daddi $a0, $a0, -48
daddi $a1, $a1, -48
dadd $t2, $a0, $a1

;imprimir

lwu $t1, DATA(r0) ; $t1 = dirección de DATA
sd $t2, 0($t1)

lwu $s0, CONTROL(r0) ; $s0 = dirección de CONTROL
daddi $t0, $0, 6 ; $t0 = 6 -> función 6: limpiar pantalla alfanumérica
sd $t0, 0($s0) ; CONTROL recibe 6 y limpia la pantalla
daddi $t0, $0, 2 ; $t0 = 2 -> función 2 para imprimir numero
sd $t0, 0($s0)

finr: jr $ra

slti $t2, $t1, 10
beqz $t2, finr;
