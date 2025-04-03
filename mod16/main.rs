use std::io;

fn count_unvisited_stones(stones: i32, birds: &[i32]) -> i32 {
    let mut visited = vec![false; (stones + 1) as usize];
    for &bird in birds {
        let mut i = bird;
        while i <= stones {
            visited[i as usize] = true;
            i += bird;
        }
    }
    (1..=stones).filter(|&i| !visited[i as usize]).count() as i32
}

fn main() {
    let mut stones_input = String::new();
    println!("Введите количество камней:");
    io::stdin().read_line(&mut stones_input).expect("Не удалось прочитать строку");
    let stones: i32 = stones_input.trim().parse().expect("Некорректный ввод");

    let mut birds_input = String::new();
    println!("Введите расстояния, которые могут преодолеть птицы (через пробел):");
    io::stdin().read_line(&mut birds_input).expect("Не удалось прочитать строку");
    let birds: Vec<i32> = birds_input
        .trim()
        .split_whitespace()
        .map(|s| s.parse().expect("Некорректный ввод"))
        .collect();

    println!("Количество непосещенных камней: {}", count_unvisited_stones(stones, &birds));
}