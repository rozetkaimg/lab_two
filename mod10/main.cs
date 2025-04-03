using System;
using System.Collections.Generic;
using System.Linq;

public class LongestChain
{
    public static string FindLongestChainEndpoint(KeyValuePair<string, string>[] pairs)
    {
        if (pairs.Length == 0)
        {
            return "Нет пар для анализа";
        }

        var graph = new Dictionary<string, string>();
        foreach (var pair in pairs)
        {
            if (pair.Key == pair.Value)
            {
                return "обратитесь к специалисту";
            }
            graph[pair.Key] = pair.Value;
        }

        string longestChainEndpoint = "";
        int maxLength = 0;

        foreach (var start in graph.Keys)
        {
            string current = start;
            int length = 1;
            while (graph.ContainsKey(current))
            {
                current = graph[current];
                length++;
            }

            if (length > maxLength)
            {
                maxLength = length;
                longestChainEndpoint = current;
            }
        }

        return longestChainEndpoint;
    }

    public static void Main(string[] args)
    {
        Console.WriteLine("Введите количество пар:");
        int numPairs;
        if (!int.TryParse(Console.ReadLine(), out numPairs) || numPairs <= 0)
        {
            Console.WriteLine("Некорректный ввод количества пар.");
            return;
        }

        var pairs = new KeyValuePair<string, string>[numPairs];
        for (int i = 0; i < numPairs; ++i)
        {
            Console.WriteLine("Введите пару (начальный пункт конечный пункт):");
            string input = Console.ReadLine();
            string[] parts = input.Split(' ');
            if (parts.Length == 2)
            {
                pairs[i] = new KeyValuePair<string, string>(parts[0], parts[1]);
            }
            else
            {
                Console.WriteLine("Некорректный ввод пары. Попробуйте снова.");
                return;
            }
        }

        // Проверка на пустые пары внутри массива.
        var filteredPairs = pairs.Where(pair => !string.IsNullOrEmpty(pair.Key) && !string.IsNullOrEmpty(pair.Value)).ToArray();

        string result = FindLongestChainEndpoint(filteredPairs);
        Console.WriteLine($"Итоговый конечный пункт: {result}");
    }
}