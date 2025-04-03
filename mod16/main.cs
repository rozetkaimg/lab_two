using System;
using System.Collections.Generic;
using System.Linq;

public class Program
{
    public static int CountUnvisitedStones(int stones, List<int> birds)
    {
        bool[] visited = new bool[stones + 1]; // Создаем массив для отслеживания посещенных камней.
        foreach (int bird in birds) // Перебираем каждую птицу.
        {
            for (int i = bird; i <= stones; i += bird) // Перебираем камни, которые может посетить птица.
            {
                visited[i] = true; // Помечаем камень как посещенный.
            }
        }
        return Enumerable.Range(1, stones).Count(i => !visited[i]); // Подсчитываем количество непосещенных камней.
    }

    public static void Main(string[] args)
    {
        Console.Write("Введите количество камней: ");
        int stones = int.Parse(Console.ReadLine()); // Получаем общее количество камней от пользователя.

        Console.Write("Введите расстояния, которые могут преодолеть птицы (через пробел): ");
        List<int> birds = Console.ReadLine().Split(' ').Select(int.Parse).ToList(); // Получаем расстояния, которые могут преодолевать птицы, от пользователя.

        Console.WriteLine($"Количество непосещенных камней: {CountUnvisitedStones(stones, birds)}"); // Выводим результат.
    }
}