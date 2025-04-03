<?php

function findLongestChainEndpoint(array $pairs): string {
    if (empty($pairs)) {
        return "Нет пар для анализа";
    }

    $graph = [];
    foreach ($pairs as $pair) {
        if ($pair[0] === $pair[1]) {
            return "обратитесь к специалисту";
        }
        $graph[$pair[0]] = $pair[1];
    }

    $longestChainEndpoint = "";
    $maxLength = 0;

    foreach (array_keys($graph) as $start) {
        $current = $start;
        $length = 1;
        while (isset($graph[$current])) {
            $current = $graph[$current];
            $length++;
        }

        if ($length > $maxLength) {
            $maxLength = $length;
            $longestChainEndpoint = $current;
        }
    }

    return $longestChainEndpoint;
}

function main() {
    echo "Введите количество пар:\n";
    $numPairs = (int) readline();

    if ($numPairs <= 0) {
        echo "Некорректный ввод количества пар.\n";
        return;
    }

    $pairs = [];
    for ($i = 0; $i < $numPairs; $i++) {
        echo "Введите пару (начальный пункт конечный пункт):\n";
        $input = readline();
        $parts = explode(" ", $input);
        if (count($parts) == 2) {
            $pairs[] = [$parts[0], $parts[1]];
        } else {
            echo "Некорректный ввод пары. Попробуйте снова.\n";
            return;
        }
    }

    // Проверка на пустые пары внутри массива.
    $filteredPairs = array_filter($pairs, function ($pair) {
        return !empty($pair[0]) && !empty($pair[1]);
    });

    $result = findLongestChainEndpoint($filteredPairs);
    echo "Итоговый конечный пункт: " . $result . "\n";
}

main();

?>