<?php

function countUnvisitedStones(int $stones, array $birds): int {
    $visited = array_fill(1, $stones, false); // Создаем массив для отслеживания посещенных камней.
    foreach ($birds as $bird) { // Перебираем каждую птицу.
        for ($i = $bird; $i <= $stones; $i += $bird) { // Перебираем камни, которые может посетить птица.
            $visited[$i] = true; // Помечаем камень как посещенный.
        }
    }
    $unvisitedCount = 0;
    for ($i = 1; $i <= $stones; $i++) { // Подсчитываем количество непосещенных камней.
        if (!$visited[$i]) {
            $unvisitedCount++;
        }
    }
    return $unvisitedCount;
}

echo "Введите количество камней: ";
$stones = (int) readline(); // Получаем общее количество камней от пользователя.

echo "Введите расстояния, которые могут преодолеть птицы (через пробел): ";
$birdsInput = readline();
$birdsStrings = explode(" ", $birdsInput);
$birds = array_map('intval', $birdsStrings); // Получаем расстояния, которые могут преодолевать птицы, от пользователя.

echo "Количество непосещенных камней: " . countUnvisitedStones($stones, $birds) . PHP_EOL; // Выводим результат.
?>