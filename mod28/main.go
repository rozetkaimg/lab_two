package main

import (
        "bufio"
        "fmt"
        "os"
        "strconv"
        "strings"
)

func countNumbersWithSumGreaterThan10(numbers []int) int {
        count := 0
        for _, number := range numbers {
                sum := 0
                temp := number
                for temp > 0 {
                        sum += temp % 10
                        temp /= 10
                }
                if sum > 10 {
                        count++
                }
        }
        return count
}

func main() {
        reader := bufio.NewReader(os.Stdin)
        fmt.Print("Введите список чисел, разделенных пробелами: ")
        input, _ := reader.ReadString('\n')
        input = strings.TrimSpace(input)
        inputNumbers := strings.Split(input, " ")

        numbers := []int{}
        for _, numStr := range inputNumbers {
                num, err := strconv.Atoi(numStr)
                if err != nil {
                        fmt.Printf("Некорректный ввод: %s. Это значение будет пропущено.\n", numStr)
                        continue
                }
                numbers = append(numbers, num)
        }

        result := countNumbersWithSumGreaterThan10(numbers)
        fmt.Printf("Количество чисел с суммой цифр > 10: %d\n", result)
}