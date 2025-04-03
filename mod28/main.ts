function countNumbersWithSumGreaterThan10(numbers: number[]): number {
    let count = 0;
    for (const number of numbers) {
        let sum = 0;
        let temp = number;
        while (temp > 0) {
            sum += temp % 10;
            temp = Math.floor(temp / 10);
        }
        if (sum > 10) {
            count++;
        }
    }
    return count;
}

const readline = require('readline');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

rl.question('Введите список чисел, разделенных пробелами: ', (input: string) => {
    const inputNumbers = input.split(' ').filter(str => str !== '');
    const numbers: number[] = [];
    for (const numStr of inputNumbers) {
        const num = parseInt(numStr);
        if (!isNaN(num)) {
            numbers.push(num);
        } else {
            console.error(`Некорректный ввод: ${numStr}. Это значение будет пропущено.`);
        }
    }

    const result = countNumbersWithSumGreaterThan10(numbers);
    console.log(`Количество чисел с суммой цифр > 10: ${result}`);
    rl.close();
});