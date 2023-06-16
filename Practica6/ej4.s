.data
CONTROL: .word32 0x10000
DATA: .word32 0x10008
res: .asciiz "Bienvenido"
res2: .asciiz "ERROR"
CLAVE: .asciiz "hola"
CLAVE2: .asciiz "S"
long: .word 4

.code
ld $t1, long($0)
daddi $t2, $0, CLAVE2

;Bucle para ingresar cadena
loop: jal char
sb $v0, 0($t2)
daddi $t1, $t1, -1
daddi $t2, $t2, 1
bnez $t1, loop

;Bucle para comparar si las cadenas son iguales o no
ld $a1, long($0) ;Uso la longitud como parametro hacia resultado para saber si las cadenas son iguales o no
daddi $t2, $0, CLAVE
daddi $t3, $0, CLAVE2
loop2: lbu $t4, 0($t2)
lbu $t5, 0($t3)
daddi $t2, $t2, 1
daddi $t3, $t3, 1
daddi $a1, $a1, -1
bne $t4, $t5, finloop
bnez $a1, loop2

;Pusheo las direcciones de las cadenas a mostrar
finloop: daddi $sp, $0, 0x400
daddi $sp, $sp, -8
daddi $t0, $0, res
sd $t0, 0($sp)
daddi $sp, $sp, -8
daddi $t0, $0, res2
sd $t0, 0($sp)

jal respuesta
halt

;Subrutina para ingresar un caracter
char: lwu $s0, CONTROL($0)
daddi $t0, $0, 9
sd $t0, 0($s0)
lwu $t0, DATA($0)
lbu $v0, 0($t0)
jr $ra

;Subrutina para mostrar resultado dependiendo de la cadena ingresada
respuesta: 
bnez $a1, mostrarError
ld $s0, 8($sp)
lwu $t0, DATA($0)
sd $s0, 0($t0)
lwu $t1, CONTROL($0)
daddi $t2, $0, 4
sd $t2, 0($t1)
j finr

mostrarError: ld $s0, 0($sp)
lwu $t0, DATA($0)
sd $s0, 0($t0)
lwu $t1, CONTROL($0)
daddi $t2, $0, 4
sd $t2, 0($t1)

finr: jr $ra