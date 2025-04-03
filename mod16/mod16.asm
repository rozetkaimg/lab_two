.global _main
.align 2

_main:
    // Сохраняем регистры
    stp x29, x30, [sp, #-16]!
    stp x20, x21, [sp, #-16]!
    stp x22, x23, [sp, #-16]!
    stp x24, x25, [sp, #-16]!

    // Выводим приглашение для ввода количества камней
    adrp x0, prompt1@PAGE
    add x0, x0, prompt1@PAGEOFF
    bl _printf

    // Читаем количество камней
    adrp x0, scan_fmt@PAGE
    add x0, x0, scan_fmt@PAGEOFF
    adrp x1, stones@PAGE
    add x1, x1, stones@PAGEOFF
    bl _scanf
    ldr w20, [x1]           // w20 = stones

    // Выводим приглашение для ввода расстояний
    adrp x0, prompt2@PAGE
    add x0, x0, prompt2@PAGEOFF
    bl _printf

    // Читаем строку с расстояниями
    mov x0, #0              // stdin
    adrp x1, input_buffer@PAGE
    add x1, x1, input_buffer@PAGEOFF
    mov x2, #100            // размер буфера
    bl _read

    // Парсим расстояния
    adrp x21, birds@PAGE
    add x21, x21, birds@PAGEOFF
    mov x22, #0             // счетчик птиц
    adrp x0, input_buffer@PAGE
    add x0, x0, input_buffer@PAGEOFF
    adrp x1, scan_fmt@PAGE
    add x1, x1, scan_fmt@PAGEOFF

parse_loop:
    add x2, x21, x22, lsl #2
    bl _sscanf
    cmp w0, #1
    b.ne parse_done
    add x22, x22, #1
    b parse_loop

parse_done:
    // Инициализируем массив посещений
    add x0, x20, #1
    bl _malloc
    mov x23, x0             // x23 = visited array
    mov x1, #0
    mov x2, x20
    bl _memset

    // Помечаем посещенные камни
    mov x24, #0             // индекс птицы
mark_loop:
    cmp x24, x22
    b.ge mark_done
    ldr w25, [x21, x24, lsl #2]  // w25 = birds[i]
    mov x0, x25
    mov x1, x25
    mov x2, x20
    bl mark_stones
    add x24, x24, #1
    b mark_loop

mark_done:
    // Считаем непосещенные камни
    mov x0, x23
    mov x1, x20
    bl count_unvisited
    mov x20, x0             // сохраняем результат

    // Выводим результат
    adrp x0, result_fmt@PAGE
    add x0, x0, result_fmt@PAGEOFF
    mov x1, x20
    bl _printf

    // Освобождаем память
    mov x0, x23
    bl _free

    // Восстанавливаем регистры и завершаем
    ldp x24, x25, [sp], #16
    ldp x22, x23, [sp], #16
    ldp x20, x21, [sp], #16
    ldp x29, x30, [sp], #16
    mov x0, #0
    ret

// Функция для пометки посещенных камней
mark_stones:
    // x0 = start, x1 = step, x2 = stones
    sub sp, sp, #16
    stp x29, x30, [sp]
    mov x3, x0              // текущий камень
mark_loop_inner:
    cmp x3, x2
    b.gt mark_done_inner
    strb wzr, [x23, x3]     // visited[stone] = true
    add x3, x3, x1          // stone += step
    b mark_loop_inner
mark_done_inner:
    ldp x29, x30, [sp], #16
    ret

// Функция для подсчета непосещенных камней
count_unvisited:
    // x0 = visited, x1 = stones
    mov x2, #1              // счетчик камней
    mov x3, #0              // счетчик непосещенных
count_loop:
    cmp x2, x1
    b.gt count_done
    ldrb w4, [x0, x2]
    cbz w4, not_visited
    b next_stone
not_visited:
    add x3, x3, #1
next_stone:
    add x2, x2, #1
    b count_loop
count_done:
    mov x0, x3
    ret

// Данные
.data
prompt1:    .asciz "Введите количество камней: "
prompt2:    .asciz "Введите расстояния, которые могут преодолеть птицы (через пробел): "
scan_fmt:   .asciz "%d"
result_fmt: .asciz "Количество непосещенных камней: %d\n"
stones:     .word 0
birds:      .space 400
input_buffer: .space 100