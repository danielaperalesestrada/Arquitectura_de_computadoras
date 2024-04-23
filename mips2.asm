.text
.globl main

main:
    # Cargar la dirección base de la lista y su tamaño
    la $s0, array   # Cargar la dirección base de la lista en $s0
    lw $t0, size    # Cargar el tamaño de la lista en $t0

    # Llamar a la función de ordenación
    jal selection_sort

# Función de ordenación por selección
selection_sort:
    # $s0 - Dirección base del array
    # $t0 - Tamaño del array

    addi $sp, $sp, -8         # Reservar espacio en la pila
    sw $s0, 0($sp)             # Guardar dirección base del array en la pila
    sw $t0, 4($sp)             # Guardar tamaño del array en la pila

    li $t1, 0                  # $t1 = i (índice del primer elemento no ordenado)
outer_loop:
    bge $t1, $t0, done_sort    # Si i >= tamaño del array, finalizar

    li $t2, 0                  # $t2 = j (índice del segundo elemento no ordenado)
    add $t3, $s0, $t1          # $t3 = Dirección del primer elemento no ordenado
    lw $t4, 0($t3)             # $t4 = Valor del primer elemento no ordenado

inner_loop:
    bge $t2, $t0, next_iter   # Si j >= tamaño del array, ir a la próxima iteración del bucle exterior

    add $t5, $t3, $zero        # $t5 = Dirección del segundo elemento no ordenado (usar $t3, no $s0)
    lw $t6, 0($t5)             # $t6 = Valor del segundo elemento no ordenado
    slt $t7, $t6, $t4          # ¿Valor del segundo elemento < Valor del primer elemento?
    beq $t7, $zero, not_swap   # Si no, ir a not_swap

    # Intercambiar los elementos
    sw $t6, 0($t3)             # Segundo elemento en la posición del primero
    sw $t4, 0($t5)             # Primer elemento en la posición del segundo
    move $t4, $t6              # Actualizar el valor del primer elemento

not_swap:
    addi $t2, $t2, 1           # Incrementar j
    j inner_loop

next_iter:
    addi $t1, $t1, 1           # Incrementar i
    j outer_loop

done_sort:
    lw $s0, 0($sp)             # Restaurar dirección base del array desde la pila
    lw $t0, 4($sp)             # Restaurar tamaño del array desde la pila
    addi $sp, $sp, 8           # Liberar espacio en la pila
    jr $ra                     # Retornar

.data
array: .word 5, 2, 4          # Ejemplo de una lista desordenada
size: .word 3                  # Tamaño de la lista
