import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Main {
    public static int countUnvisitedStones(int stones, List<Integer> birds) {
        boolean[] visited = new boolean[stones + 1]; // Создаем массив для отслеживания посещенных камней.
        for (int bird : birds) { // Перебираем каждую птицу.
            for (int i = bird; i <= stones; i += bird) { // Перебираем камни, которые может посетить птица.
                visited[i] = true; // Помечаем камень как посещенный.
            }
        }
        return (int) IntStream.rangeClosed(1, stones).filter(i -> !visited[i]).count(); // Подсчитываем количество непосещенных камней.
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Введите количество камней: ");
        int stones = scanner.nextInt(); // Получаем общее количество камней от пользователя.
        scanner.nextLine(); // Очищаем буфер после ввода числа

        System.out.print("Введите расстояния, которые могут преодолеть птицы (через пробел): ");
        String birdsInput = scanner.nextLine();
        List<Integer> birds = new ArrayList<>();
        String[] birdsStrings = birdsInput.split(" ");
        for (String birdString : birdsStrings) {
            birds.add(Integer.parseInt(birdString)); // Получаем расстояния, которые могут преодолевать птицы, от пользователя.
        }

        System.out.println("Количество непосещенных камней: " + countUnvisitedStones(stones, birds)); // Выводим результат.
        scanner.close();
    }
}