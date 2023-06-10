.data
CONTROL: .word32 0x10000
DATA: .word32 0x10008
NUMS: .asciiz "Cero  ", "Uno   ", "Dos   ", "Tres  ", "Cuatro", "Cinco ", "Seis  ", "Siete ", "Ocho  ", "Nueve "
.code 
daddi $sp, $0, 0x400
daddi $a1, $0, NUMS

jal ingreso
halt

ingreso: lwu $s0, CONTROL($0)
daddi $t0, $0, 8
sd $t0, 0($s0)
lwu $s1, DATA($0)
lbu $a0, 0($s1)
daddi $sp, $sp, -8
sd $ra, 0($sp)
; jal verificar
daddi $t1, $a0, 48
slti $t2, $t1, 58
beqz $t2, finr
;verificacion
jal mostrar
finr: ld $ra, 0($sp)
daddi $sp, $sp, 8
jr $ra


mostrar: lwu $s0, DATA(r0) ; $s0 = dirección de DATA
daddi $t2, $0, 6
dmul $t1, $a0, $t2

daddi $t0, $0, NUMS ; $t0 = dirección del mensaje a mostrar
dadd $t0, $t0, $t1
sd $t0, 0($s0) ; DATA recibe el puntero al comienzo del mensaje
lwu $s1, CONTROL(r0) ; $s1 = dirección de CONTROL
daddi $t0, $0, 6 ; $t0 = 6 -> función 6: limpiar pantalla alfanumérica
sd $t0, 0($s1) ; CONTROL recibe 6 y limpia la pantalla
daddi $t0, $0, 4 ; $t0 = 4 -> función 4: salida de una cadena ASCII
sd $t0, 0($s1)
jr $ra
;Separo la cadena y luego imprimo corriendo de a 6 caracteres