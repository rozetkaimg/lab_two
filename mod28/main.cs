using System;
using System.Collections.Generic;
using System.Linq;

public class CountNumbersWithSumGreaterThan10
{
    public static int CountNumbersWithSumGreaterThan10Method(List<int> numbers)
    {
        int count = 0;
        foreach (int number in numbers)
        {
            int sum = 0;
            int temp = number;
            while (temp > 0)
            {
                sum += temp % 10;
                temp /= 10;
            }
            if (sum > 10)
            {
                count++;
            }
        }
        return count;
    }

    public static void Main(string[] args)
    {
        Console.Write("Введите список чисел, разделенных пробелами: ");
        string input = Console.ReadLine();
        List<int> numbers = new List<int>();
        string[] inputNumbers = input.Split(' ');

        foreach (string numStr in inputNumbers)
        {
            if (int.TryParse(numStr, out int num))
            {
                numbers.Add(num);
            }
            else
            {
                Console.WriteLine($"Некорректный ввод: {numStr}. Это значение будет пропущено.");
            }
        }

        int result = CountNumbersWithSumGreaterThan10Method(numbers);
        Console.WriteLine($"Количество чисел с суммой цифр > 10: {result}");
    }
}