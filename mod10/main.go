package main

import (
        "bufio"
        "fmt"
        "os"
        "strconv"
        "strings"
)

func findLongestChainEndpoint(pairs [][]string) string {
        if len(pairs) == 0 {
                return "Нет пар для анализа"
        }

        graph := make(map[string]string)
        for _, pair := range pairs {
                if pair[0] == pair[1] {
                        return "обратитесь к специалисту"
                }
                graph[pair[0]] = pair[1]
        }

        longestChainEndpoint := ""
        maxLength := 0

        for start := range graph {
                current := start
                length := 1
                for {
                        next, ok := graph[current]
                        if !ok {
                                break
                        }
                        current = next
                        length++
                }

                if length > maxLength {
                        maxLength = length
                        longestChainEndpoint = current
                }
        }

        return longestChainEndpoint
}

func main() {
        reader := bufio.NewReader(os.Stdin)

        fmt.Println("Введите количество пар:")
        numPairsStr, _ := reader.ReadString('\n')
        numPairs, err := strconv.Atoi(strings.TrimSpace(numPairsStr))
        if err != nil || numPairs <= 0 {
                fmt.Println("Некорректный ввод количества пар.")
                return
        }

        pairs := make([][]string, numPairs)
        for i := 0; i < numPairs; i++ {
                fmt.Println("Введите пару (начальный пункт конечный пункт):")
                input, _ := reader.ReadString('\n')
                parts := strings.Fields(input)
                if len(parts) == 2 {
                        pairs[i] = parts
                } else {
                        fmt.Println("Некорректный ввод пары. Попробуйте снова.")
                        return
                }
        }

        // Проверка на пустые пары внутри массива.
        filteredPairs := make([][]string, 0)
        for _, pair := range pairs {
                if len(pair) == 2 && pair[0] != "" && pair[1] != "" {
                        filteredPairs = append(filteredPairs, pair)
                }
        }

        result := findLongestChainEndpoint(filteredPairs)
        fmt.Println("Итоговый конечный пункт:", result)
}