use std::io;

fn count_numbers_with_sum_greater_than_10(numbers: &[i32]) -> i32 {
    let mut count = 0;
    for &number in numbers {
        let mut sum = 0;
        let mut temp = number;
        while temp > 0 {
            sum += temp % 10;
            temp /= 10;
        }
        if sum > 10 {
            count += 1;
        }
    }
    count
}

fn main() {
    println!("Введите список чисел, разделенных пробелами:");

    let mut input = String::new();
    io::stdin()
        .read_line(&mut input)
        .expect("Не удалось прочитать строку");

    let numbers: Vec<i32> = input
        .split_whitespace()
        .filter_map(|s| s.parse().ok())
        .collect();

    let result = count_numbers_with_sum_greater_than_10(&numbers);
    println!("Количество чисел с суммой цифр > 10: {}", result);
}