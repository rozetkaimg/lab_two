def calculate_digit_sum(number):
    """Вычисляет сумму цифр числа"""
    sum_digits = 0
    while number > 0:
        sum_digits += number % 10  # Добавляем последнюю цифру
        number = number // 10     # Удаляем последнюю цифру
    return sum_digits

def count_numbers_with_sum_gt_10(numbers):
    """Подсчитывает числа с суммой цифр > 10"""
    count = 0
    for num in numbers:
        if calculate_digit_sum(num) > 10:
            count += 1
    return count

def main():
    print("Введите список чисел, разделенных пробелами: ", end='')
    input_str = input().strip()
    
    # Преобразуем ввод в список чисел с обработкой ошибок
    numbers = []
    for num_str in input_str.split():
        try:
            num = int(num_str)
            numbers.append(num)
        except ValueError:
            print(f"Некорректное число: '{num_str}'. Пропускаем.")
    
    result = count_numbers_with_sum_gt_10(numbers)
    print(f"Количество чисел с суммой цифр > 10: {result}")

if __name__ == "__main__":
    main()