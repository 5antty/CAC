.data
coorX: .byte 24 ; coordenada X de un punto
coorY: .byte 24 ; coordenada Y de un punto
color: .byte 255, 0, 255, 0 ; color: máximo rojo + máximo azul => magenta
CONTROL: .word32 0x10000
DATA: .word32 0x10008
.text
lwu $s6, CONTROL(r0) ; $s6 = dirección de CONTROL
lwu $s7, DATA(r0) ; $s7 = dirección de DATA

daddi $t0, $0, 7 ; $t0 = 7 -> función 7: limpiar pantalla gráfica
sd $t0, 0($s6) ; CONTROL recibe 7 y limpia la pantalla gráfica

;Ingreso de coordenada x
daddi $a0, $0, coorX
jal ingresoCoor ; $v0 = valor de coordenada X
lbu $s0, coorX(r0) 
sb $s0, 5($s7) ; DATA+5 recibe el valor de coordenada X

;Ingreso de coordenada y
daddi $a0, $0, coorY
jal ingresoCoor ; $v0 = valor de coordenada y
lbu $s1, coorY(r0) 
sb $s1, 4($s7) ; DATA+4 recibe el valor de coordenada Y

;Ingreso del color

lwu $s2, color(r0) ; $s2 = valor de color a pintar
sw $s2, 0($s7) ; DATA recibe el valor del color a pintar
daddi $t0, $0, 5 ; $t0 = 5 -> función 5: salida gráfica
sd $t0, 0($s6) ; CONTROL recibe 5 y produce el dibujo del punto
halt

ingresoCoor: lwu $t0, CONTROL($0)
daddi $t1, $0, 8
sd $t1, 0($t0)
lwu $t0, DATA($0)
lbu $t1, 0($t0)
sb $t1, 0($a0)
jr $ra