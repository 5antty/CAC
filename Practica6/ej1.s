.data

CONTROL: .word32 0x10000
DATA: .word32 0x10008
long: .word 5
texto: .asciiz "abcd" ; El mensaje a mostrar
.text
daddi $a1, $0, texto
ld $a2, long($0)
jal subr

lwu $s0, DATA(r0) ; $s0 = dirección de DATA
daddi $t0, $0, texto ; $t0 = dirección del mensaje a mostrar
sd $t0, 0($s0) ; DATA recibe el puntero al comienzo del mensaje
lwu $s1, CONTROL(r0) ; $s1 = dirección de CONTROL
daddi $t0, $0, 6 ; $t0 = 6 -> función 6: limpiar pantalla alfanumérica
sd $t0, 0($s1) ; CONTROL recibe 6 y limpia la pantalla
daddi $t0, $0, 4 ; $t0 = 4 -> función 4: salida de una cadena ASCII
sd $t0, 0($s1) ; CONTROL recibe 4 y produce la salida del mensaje
halt

subr: 
loop: lwu $s0, CONTROL(r0) ; $s0 = dirección de CONTROL
daddi $t0, $0, 9 ; $t0 = 9 -> función 9: para leer un caracter
sd $t0, 0($s0)
lwu $t1, DATA(r0) ; $t1 = dirección de DATA
lbu $t2, 0($t1)
sb $t2, 0($a1) ;guardo el caracter leido
nop
daddi $t3, $0, 48 ; termina cuando tecleo 0 (30h)
daddi $a1, $a1, 1 ;corrimiento en la cadena
beq $t2, $t3, finr
j loop
finr: jr $ra