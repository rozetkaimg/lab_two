import Foundation

func countNumbersWithSumGreaterThan10(numbers: [Int]) -> Int {
    var count = 0
    for number in numbers {
        var sum = 0
        var temp = number
        while temp > 0 {
            sum += temp % 10
            temp /= 10
        }
        if sum > 10 {
            count += 1
        }
    }
    return count
}

func main() {
    print("Введите список чисел, разделенных пробелами: ", terminator: "")
    guard let input = readLine() else {
        print("Ошибка чтения ввода.")
        return
    }

    let inputNumbers = input.split(separator: " ").compactMap { Int($0) }
    let numbers = inputNumbers

    let result = countNumbersWithSumGreaterThan10(numbers: numbers)
    print("Количество чисел с суммой цифр > 10: \(result)")
}

main()