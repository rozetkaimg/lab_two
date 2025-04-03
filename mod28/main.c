object CountNumbersWithSumGreaterThan10 {
    fun countNumbersWithSumGreaterThan10(numbers: List<Int>): Int {
        var count = 0
        for (number in numbers) {
            var sum = 0
            var temp = number
            while (temp > 0) {
                sum += temp % 10
                temp /= 10
            }
            if (sum > 10) {
                count++
            }
        }
        return count
    }

    @JvmStatic
    fun main(args: Array<String>) {
        val scanner = java.util.Scanner(System.`in`)
        print("Введите список чисел, разделенных пробелами: ")
        val input = scanner.nextLine()
        val inputNumbers = input.split(" ").filter { it.isNotEmpty() } // Improved splitting and filtering
        val numbers = mutableListOf<Int>()
        for (numStr in inputNumbers) {
            try {
                val num = numStr.toInt()
                numbers.add(num)
            } catch (e: NumberFormatException) {
                println("Некорректный ввод: $numStr. Это значение будет пропущено.") //Added print to user which input was invalid
            }
        }

        val result = countNumbersWithSumGreaterThan10(numbers)
        println("Количество чисел с суммой цифр > 10: $result")
        scanner.close()
    }
}