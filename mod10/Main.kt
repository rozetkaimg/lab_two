fun findLongestChainEndpoint(pairs: Array<Pair<String, String>>): String {
    if (pairs.isEmpty()) {
        return "Нет пар для анализа"
    }

    val graph = mutableMapOf<String, String>()
    for (pair in pairs) {
        if (pair.first == pair.second) {
            return "обратитесь к специалисту"
        }
        graph[pair.first] = pair.second
    }

    var longestChainEndpoint = ""
    var maxLength = 0

    for (start in graph.keys) {
        var current = start
        var length = 1
        while (graph.containsKey(current)) {
            current = graph[current]!!
            length++
        }

        if (length > maxLength) {
            maxLength = length
            longestChainEndpoint = current
        }
    }

    return longestChainEndpoint
}

fun main() {
    println("Введите количество пар:")
    val numPairs = readLine()?.toIntOrNull() ?: 0

    if (numPairs <= 0) {
        println("Некорректный ввод количества пар.")
        return
    }

    val pairs = Array(numPairs) {
        println("Введите пару (начальный пункт конечный пункт):")
        val input = readLine()?.split(" ") ?: listOf() // Изменено здесь
        if (input.size == 2) {
            Pair(input[0], input[1])
        } else {
            println("Некорректный ввод пары. Попробуйте снова.")
            return@Array Pair("", "") // Возвращаем пустую пару и просим ввести снова
        }
    }

    //Проверка на пустые пары внутри массива.
    val filteredPairs = pairs.filter { it.first.isNotEmpty() && it.second.isNotEmpty() }.toTypedArray()

    val result = findLongestChainEndpoint(filteredPairs)
    println("Итоговый конечный пункт: $result")
}