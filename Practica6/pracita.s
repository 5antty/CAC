.data
texto: .asciiz "s" ; El mensaje a mostrar
CONTROL: .word32 0x10000
DATA: .word32 0x10008
long: .word 8
.text

 ; DATA recibe el puntero al comienzo del mensaje
lwu $s1, CONTROL(r0) ; $s1 = dirección de CONTROL
daddi $t0, $0, 9 ; $t0 = 6 -> función 6: limpiar pantalla alfanumérica
sd $t0, 0($s1) ; CONTROL recibe 9 para entrada de datos
lwu $s0, DATA(r0) ; $s0 = dirección de DATA
lbu $s2, 0($s0)
sd $s2, texto($0)

daddi $t0, $0, 4 ; $t0 = 4 -> función 4: salida de una cadena ASCII
sd $t0, 0($s1) ; CONTROL recibe 4 y produce la salida del mensaje
halt