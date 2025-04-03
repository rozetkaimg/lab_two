#include <iostream>
#include <vector>

int countUnvisitedStones(int stones, const std::vector<int>& birds) {
    std::vector<bool> visited(stones + 1, false); // Создаем вектор для отслеживания посещенных камней.
    for (int bird : birds) { // Перебираем каждую птицу.
        for (int i = bird; i <= stones; i += bird) { // Перебираем камни, которые может посетить птица.
            visited[i] = true; // Помечаем камень как посещенный.
        }
    }
    int unvisitedCount = 0;
    for (int i = 1; i <= stones; ++i) { // Подсчитываем количество непосещенных камней.
        if (!visited[i]) {
            unvisitedCount++;
        }
    }
    return unvisitedCount;
}

int main() {
    int stones;
    std::cout << "Введите количество камней: ";
    std::cin >> stones; // Получаем общее количество камней от пользователя.

    std::cout << "Введите расстояния, которые могут преодолеть птицы (через пробел): ";
    std::vector<int> birds;
    int bird;
    while (std::cin >> bird) { // Получаем расстояния, которые могут преодолевать птицы, от пользователя.
        birds.push_back(bird);
        if (std::cin.peek() == '\n') {
            break;
        }
    }

    std::cout << "Количество непосещенных камней: " << countUnvisitedStones(stones, birds) << std::endl; // Выводим результат.
    return 0;
}