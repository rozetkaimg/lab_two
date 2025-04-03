<?php

function countNumbersWithSumGreaterThan10(array $numbers): int {
    $count = 0;
    foreach ($numbers as $number) {
        $sum = 0;
        $temp = $number;
        while ($temp > 0) {
            $sum += $temp % 10;
            $temp = (int)($temp / 10);
        }
        if ($sum > 10) {
            $count++;
        }
    }
    return $count;
}

echo "Введите список чисел, разделенных пробелами: ";
$input = trim(fgets(STDIN));
$inputNumbers = explode(" ", $input);

$numbers = [];
foreach ($inputNumbers as $numStr) {
    $num = (int)$numStr;
    if (is_numeric($numStr)) {
        $numbers[] = $num;
    } else {
        echo "Некорректный ввод: $numStr. Это значение будет пропущено.\n";
    }

}

$result = countNumbersWithSumGreaterThan10($numbers);
echo "Количество чисел с суммой цифр > 10: $result\n";

?>