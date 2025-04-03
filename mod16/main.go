package main

import (
        "bufio"
        "fmt"
        "os"
        "strconv"
        "strings"
)

func countUnvisitedStones(stones int, birds []int) int {
        visited := make([]bool, stones+1) // Создаем срез для отслеживания посещенных камней.
        for _, bird := range birds {       // Перебираем каждую птицу.
                for i := bird; i <= stones; i += bird { // Перебираем камни, которые может посетить птица.
                        visited[i] = true // Помечаем камень как посещенный.
                }
        }
        unvisitedCount := 0
        for i := 1; i <= stones; i++ { // Подсчитываем количество непосещенных камней.
                if !visited[i] {
                        unvisitedCount++
                }
        }
        return unvisitedCount
}

func main() {
        reader := bufio.NewReader(os.Stdin)

        fmt.Print("Введите количество камней: ")
        stonesStr, _ := reader.ReadString('\n')
        stones, _ := strconv.Atoi(strings.TrimSpace(stonesStr)) // Получаем общее количество камней от пользователя.

        fmt.Print("Введите расстояния, которые могут преодолеть птицы (через пробел): ")
        birdsStr, _ := reader.ReadString('\n')
        birdsStr = strings.TrimSpace(birdsStr)
        birdsStrs := strings.Split(birdsStr, " ")
        birds := make([]int, len(birdsStrs))

        for i, birdStr := range birdsStrs {
                birds[i], _ = strconv.Atoi(birdStr) // Получаем расстояния, которые могут преодолевать птицы, от пользователя.
        }

        fmt.Println("Количество непосещенных камней:", countUnvisitedStones(stones, birds)) // Выводим результат.
}