object CountNumbersWithSumGreaterThan10 {
    fun countNumbersWithSumGreaterThan10(numbers: List<Int>): Int {
        var count: Int = 0
        for (number: Int in numbers) {
            var sum: Int = 0
            var temp: Int = number
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
        val scanner: java.util.Scanner = java.util.Scanner(java.lang.System.`in`)
        kotlin.io.print("Введите список чисел, разделенных пробелами: ")
        val input: String = scanner.nextLine()
        val inputNumbers: Array<String> = input.split(" ".toRegex()).dropLastWhile { it.isEmpty() }.toTypedArray()
        val numbers: MutableList<Int> = java.util.ArrayList<Int>()
        for (numStr: String in inputNumbers) {
            try {
                val num: Int = numStr.toInt()
                numbers.add(num)
            } catch (e: java.lang.NumberFormatException) {
              
            }
        }

        val result: Int = countNumbersWithSumGreaterThan10(numbers)
        kotlin.io.println("Количество чисел с суммой цифр > 10: " + result)
        scanner.close()
    }
}