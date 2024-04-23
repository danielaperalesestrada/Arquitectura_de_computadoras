# Calcula los primeros doce números de Fibonacci y los coloca en un array, luego imprime
      .data
fibs: .word   0 : 12        # "array" de 12 palabras para contener los valores de Fibonacci
size: .word  12             # tamaño del "array" 
      .text
      la   $t0, fibs        # carga la dirección del array
      la   $t5, size        # carga la dirección de la variable de tamaño
      lw   $t5, 0($t5)      # carga el tamaño del array
      li   $t2, 1           # 1 es el primer y segundo número de Fibonacci
      add.d $f0, $f2, $f4
      sw   $t2, 0($t0)      # F[0] = 1
      sw   $t2, 4($t0)      # F[1] = F[0] = 1
      addi $t1, $t5, -2     # Contador para el bucle, se ejecutará (size-2) veces
loop: lw   $t3, 0($t0)      # Obtener valor del array F[n] 
      lw   $t4, 4($t0)      # Obtener valor del array F[n+1]
      add  $t2, $t3, $t4    # $t2 = F[n] + F[n+1]
      sw   $t2, 8($t0)      # Almacena F[n+2] = F[n] + F[n+1] en el array
      addi $t0, $t0, 4      # incrementa la dirección del número de Fibonacci origen
      addi $t1, $t1, -1     # decrementa el contador del bucle
      bgtz $t1, loop        # repetir si no ha terminado aún
      la   $a0, fibs        # primer argumento para imprimir (array)
      add  $a1, $zero, $t5  # segundo argumento para imprimir (tamaño)
      jal  print            # llama a la rutina de impresión. 
      li   $v0, 10          # llamada al sistema para salir
      syscall               # estamos fuera de aquí.
		
######### rutina para imprimir los números en una línea. 

      .data
space:.asciiz  " "          # espacio para insertar entre los números
head: .asciiz  "Los números de Fibonacci son:\n"
      .text
print:add  $t0, $zero, $a0  # dirección de inicio del array
      add  $t1, $zero, $a1  # inicializa el contador del bucle al tamaño del array
      la   $a0, head        # carga la dirección del encabezado para imprimir
      li   $v0, 4           # especifica el servicio de impresión de cadena
      syscall               # imprime el encabezado
out:  lw   $a0, 0($t0)      # carga el número de Fibonacci para la llamada al sistema
      li   $v0, 1           # especifica el servicio de impresión de entero
      syscall               # imprime el número de Fibonacci
      la   $a0, space       # carga la dirección del espacio para la llamada al sistema
      li   $v0, 4           # especifica el servicio de impresión de cadena
      syscall               # imprime el espacio
      addi $t0, $t0, 4      # incrementa la dirección
      addi $t1, $t1, -1     # decrementa el contador del bucle
      bgtz $t1, out         # repetir si no ha terminado
      jr   $ra              # retorno
