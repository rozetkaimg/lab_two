.global _main
.align 2

_main:
    stp x29, x30, [sp, #-16]!   // Сохраняем FP и LR

    // Выводим приглашение для ввода количества пар
    adrp x0, prompt_num_pairs@PAGE
    add x0, x0, prompt_num_pairs@PAGEOFF
    bl _printf

    // Читаем количество пар
    adrp x0, scan_int_fmt@PAGE
    add x0, x0, scan_int_fmt@PAGEOFF
    adrp x1, num_pairs@PAGE
    add x1, x1, num_pairs@PAGEOFF
    bl _scanf
    ldr w19, [x1]               // w19 = количество пар

    // Проверяем валидность ввода
    cmp w19, #0
    b.le invalid_input

    // Выделяем память для пар (8 байт на пару)
    lsl x0, x19, #3             // x0 = num_pairs * 8
    bl _malloc
    mov x20, x0                 // x20 = массив пар
    mov x21, #0                 // x21 = счетчик пар

input_loop:
    // Проверяем, все ли пары введены
    cmp x21, x19
    b.ge input_done

    // Выводим приглашение для ввода пары
    adrp x0, prompt_pair@PAGE
    add x0, x0, prompt_pair@PAGEOFF
    mov x1, x21
    add x1, x1, #1
    bl _printf

    // Читаем пару
    adrp x0, pair_buffer@PAGE
    add x0, x0, pair_buffer@PAGEOFF
    mov x1, #100                // Максимальная длина ввода
    bl _read

    // Парсим пару
    adrp x0, pair_buffer@PAGE
    add x0, x0, pair_buffer@PAGEOFF
    adrp x1, scan_str_fmt@PAGE
    add x1, x1, scan_str_fmt@PAGEOFF
    adrp x2, first_point@PAGE
    add x2, x2, first_point@PAGEOFF
    adrp x3, second_point@PAGE
    add x3, x3, second_point@PAGEOFF
    bl _sscanf

    // Проверяем, что введены 2 значения
    cmp w0, #2
    b.ne invalid_pair

    // Проверяем, что точки разные
    adrp x0, first_point@PAGE
    add x0, x0, first_point@PAGEOFF
    adrp x1, second_point@PAGE
    add x1, x1, second_point@PAGEOFF
    bl _strcmp
    cbz w0, same_points

    // Сохраняем пару в массив
    adrp x0, first_point@PAGE
    add x0, x0, first_point@PAGEOFF
    bl _strdup
    str x0, [x20, x21, lsl #3]  // Сохраняем указатель на первую строку

    adrp x0, second_point@PAGE
    add x0, x0, second_point@PAGEOFF
    bl _strdup
    add x22, x20, x21, lsl #3
    str x0, [x22, #8]           // Сохраняем указатель на вторую строку

    add x21, x21, #1            // Увеличиваем счетчик пар
    b input_loop

same_points:
    adrp x0, same_points_msg@PAGE
    add x0, x0, same_points_msg@PAGEOFF
    bl _puts
    b exit_program

invalid_pair:
    adrp x0, invalid_pair_msg@PAGE
    add x0, x0, invalid_pair_msg@PAGEOFF
    bl _puts
    b input_loop

invalid_input:
    adrp x0, invalid_input_msg@PAGE
    add x0, x0, invalid_input_msg@PAGEOFF
    bl _puts
    b exit_program

input_done:
    // Вызываем функцию поиска самой длинной цепочки
    mov x0, x20                 // Массив пар
    mov x1, x19                 // Количество пар
    bl find_longest_chain
    mov x22, x0                 // Сохраняем результат

    // Выводим результат
    adrp x0, result_msg@PAGE
    add x0, x0, result_msg@PAGEOFF
    mov x1, x22
    bl _printf

    // Освобождаем память
    mov x0, x20
    bl free_pairs
    b exit_program

exit_program:
    ldp x29, x30, [sp], #16     // Восстанавливаем FP и LR
    mov x0, #0                  // Код возврата 0
    ret

// Функция для поиска самой длинной цепочки
// x0 - массив пар, x1 - количество пар
find_longest_chain:
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!
    stp x21, x22, [sp, #-16]!
    stp x23, x24, [sp, #-16]!

    // Строим граф (словарь)
    mov x19, x0                 // x19 = массив пар
    mov x20, x1                 // x20 = количество пар

    // Создаем хеш-таблицу (graph)
    mov x0, #16                 // Размер начальной таблицы
    bl _dict_create
    mov x21, x0                 // x21 = graph

    // Заполняем граф
    mov x22, #0                 // x22 = индекс
fill_graph:
    cmp x22, x20
    b.ge fill_done

    // Получаем текущую пару
    ldr x0, [x19, x22, lsl #3]     // first
    ldr x1, [x19, x22, lsl #3 + 8] // second

    // Добавляем в граф: graph[first] = second
    mov x2, x1
    bl _dict_set

    add x22, x22, #1
    b fill_graph

fill_done:
    // Ищем самую длинную цепочку
    mov x0, x21                 // graph
    bl find_longest_path
    mov x23, x0                 // x23 = конечная точка

    // Освобождаем граф
    mov x0, x21
    bl _dict_destroy

    mov x0, x23                 // Возвращаем результат
    ldp x23, x24, [sp], #16
    ldp x21, x22, [sp], #16
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret

// Вспомогательные функции для работы со словарем
_dict_create:
    // Реализация создания словаря
    ret

_dict_set:
    // Реализация добавления в словарь
    ret

_dict_get:
    // Реализация получения из словаря
    ret

_dict_destroy:
    // Реализация удаления словаря
    ret

// Функция поиска самого длинного пути
find_longest_path:
    // Реализация алгоритма поиска
    ret

// Функция освобождения памяти пар
free_pairs:
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!

    mov x19, x0                 // Массив пар
    mov x20, x1                 // Количество пар

    mov x21, #0                 // Индекс
free_loop:
    cmp x21, x20
    b.ge free_done

    // Освобождаем первую строку
    ldr x0, [x19, x21, lsl #3]
    bl _free

    // Освобождаем вторую строку
    ldr x0, [x19, x21, lsl #3 + 8]
    bl _free

    add x21, x21, #1
    b free_loop

free_done:
    // Освобождаем массив
    mov x0, x19
    bl _free

    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret

.data
.align 4
prompt_num_pairs: .asciz "Введите количество пар:\n"
prompt_pair:      .asciz "Введите пару %d (начальный пункт конечный пункт):\n"
scan_int_fmt:     .asciz "%d"
scan_str_fmt:     .asciz "%s %s"
result_msg:       .asciz "Итоговый конечный пункт: %s\n"
invalid_input_msg: .asciz "Некорректный ввод количества пар.\n"
invalid_pair_msg: .asciz "Некорректный ввод пары. Попробуйте снова.\n"
same_points_msg:  .asciz "обратитесь к специалисту\n"

num_pairs:        .word 0
first_point:      .space 100
second_point:     .space 100
pair_buffer:      .space 100