fun countUnvisitedStones(stones: Int, birds: List<Int>): Int {
    val visited = BooleanArray(stones + 1) // Создаем массив для отслеживания посещенных камней.
    for (bird in birds) { // Перебираем каждую птицу.
        for (i in bird..stones step bird) { // Перебираем камни, которые может посетить птица.
            visited[i] = true // Помечаем камень как посещенный.
        }
    }
    return (1..stones).count { !visited[it] } // Подсчитываем количество непосещенных камней.
}

fun main() {
    print("Введите количество камней: ")
    val stones = readLine()!!.toInt() // Получаем общее количество камней от пользователя.

    print("Введите расстояния, которые могут преодолеть птицы (через пробел): ")
    val birds = readLine()!!.split(" ").map { it.toInt() } // Получаем расстояния, которые могут преодолевать птицы, от пользователя.

    println("Количество непосещенных камней: ${countUnvisitedStones(stones, birds)}") // Выводим результат.
}