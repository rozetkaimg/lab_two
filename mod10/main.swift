import Foundation

func findLongestChainEndpoint(pairs: [(String, String)]) -> String {
    if pairs.isEmpty {
        return "Нет пар для анализа"
    }

    var graph: [String: String] = [:]
    for pair in pairs {
        if pair.0 == pair.1 {
            return "обратитесь к специалисту"
        }
        graph[pair.0] = pair.1
    }

    var longestChainEndpoint = ""
    var maxLength = 0

    for start in graph.keys {
        var current = start
        var length = 1
        while let next = graph[current] {
            current = next
            length += 1
        }

        if length > maxLength {
            maxLength = length
            longestChainEndpoint = current
        }
    }

    return longestChainEndpoint
}

func main() {
    print("Введите количество пар:\n", terminator: "")
    guard let numPairsString = readLine(), let numPairs = Int(numPairsString), numPairs > 0 else {
        print("Некорректный ввод количества пар.")
        return
    }

    var pairs: [(String, String)] = []
    for _ in 0..<numPairs {
        print("Введите пару (начальный пункт конечный пункт):\n", terminator: "")
        guard let input = readLine() else {
            print("Некорректный ввод пары. Попробуйте снова.")
            return
        }
        let parts = input.components(separatedBy: " ")
        if parts.count == 2 {
            pairs.append((parts[0], parts[1]))
        } else {
            print("Некорректный ввод пары. Попробуйте снова.")
            return
        }
    }

    // Проверка на пустые пары внутри массива.
    let filteredPairs = pairs.filter { !$0.0.isEmpty && !$0.1.isEmpty }

    let result = findLongestChainEndpoint(pairs: filteredPairs)
    print("Итоговый конечный пункт: \(result)")
}

main()