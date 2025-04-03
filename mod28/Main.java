import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

class CountNumbersWithSumGreaterThan10 {

    public static int countNumbersWithSumGreaterThan10(List<Integer> numbers) {
        int count = 0;
        for (int number : numbers) {
            int sum = 0;
            int temp = number;
            while (temp > 0) {
                sum += temp % 10;
                temp /= 10;
            }
            if (sum > 10) {
                count++;
            }
        }
        return count;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Введите список чисел, разделенных пробелами: ");
        String input = scanner.nextLine();
        String[] inputNumbers = input.split(" ");
        List<Integer> numbers = new ArrayList<>();
        for (String numStr : inputNumbers) {
            try {
                int num = Integer.parseInt(numStr);
                numbers.add(num);
            } catch (NumberFormatException e) {

            }
        }

        int result = countNumbersWithSumGreaterThan10(numbers);
        System.out.println("Количество чисел с суммой цифр > 10: " + result);
        scanner.close();
    }
}