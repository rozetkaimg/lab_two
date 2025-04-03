import Foundation

func countUnvisitedStones(stones: Int, birds: [Int]) -> Int {
    var visited = Array(repeating: false, count: stones + 1) // Создаем массив для отслеживания посещенных камней.
    for bird in birds { // Перебираем каждую птицу.
        for i in stride(from: bird, through: stones, by: bird) { // Перебираем камни, которые может посетить птица.
            visited[i] = true // Помечаем камень как посещенный.
        }
    }
    return (1...stones).filter { !visited[$0] }.count // Подсчитываем количество непосещенных камней.
}

print("Введите количество камней: ", terminator: "")
let stones = Int(readLine()!)! // Получаем общее количество камней от пользователя.

print("Введите расстояния, которые могут преодолеть птицы (через пробел): ", terminator: "")
let birds = readLine()!.split(separator: " ").map { Int($0)! } // Получаем расстояния, которые могут преодолевать птицы, от пользователя.

print("Количество непосещенных камней: \(countUnvisitedStones(stones: stones, birds: birds))") // Выводим результат.