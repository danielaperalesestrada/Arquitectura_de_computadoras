# Inicialización de la lista A y su tamaño
# (Asumiendo que la lista A está predefinida en el código)

.data
A: .word 10, 5, 8, 3, 12, 7, 6, 15, 9, 1   # Lista de números enteros
size_A: .word 10                           # Tamaño de la lista A

.text
main:
    # Cargar dirección de inicio de la lista en $s1
    la $s1, A

    # Cargar tamaño de la lista en $s2
    lw $s2, size_A

    # Hallar el mayor entero de la lista A y colocarlo en $t0
    lw $t0, 0($s1)         # Inicializar máximo a A[0]
    addi $t1, $zero, 0     # Inicializar índice i a 0

loop:
    add $t1, $t1, 1       # Incrementar índice i por 1
    beq $t1, $s2, done    # Si todos los elementos han sido examinados, salir del bucle

    add $t2, $t1, $t1     # Calcular dirección de A[i]
    add $t2, $t2, $t2
    add $t2, $t2, $s1

    lw $t3, 0($t2)        # Cargar valor de A[i] en $t3

    slt $t4, $t0, $t3     # Comparar máximo con A[i]
    beq $t4, $zero, loop  # Si A[i] es menor o igual que máximo, continuar con el bucle

    add $t0, $t3, $zero   # Si A[i] es mayor que máximo, actualizar máximo

    j loop                # Repetir el bucle

done:
    # El mayor entero de la lista A se encuentra en $t0

    # Imprimir el resultado
    li $v0, 1           # Cargar el servicio de impresión de enteros
    move $a0, $t0       # Pasar el mayor entero en $t0 como argumento para imprimir
    syscall             # Llamar al servicio de impresión de enteros

    # Salir del programa
    li $v0, 10          # Cargar el servicio de salida
    syscall             # Salir del programa
