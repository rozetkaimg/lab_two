function findLongestChainEndpoint(pairs: [string, string][]): string {
    if (pairs.length === 0) {
        return "Нет пар для анализа";
    }

    const graph: { [key: string]: string } = {};
    for (const pair of pairs) {
        if (pair[0] === pair[1]) {
            return "обратитесь к специалисту";
        }
        graph[pair[0]] = pair[1];
    }

    let longestChainEndpoint = "";
    let maxLength = 0;

    for (const start in graph) {
        let current = start;
        let length = 1;
        while (graph[current]) {
            current = graph[current];
            length++;
        }

        if (length > maxLength) {
            maxLength = length;
            longestChainEndpoint = current;
        }
    }

    return longestChainEndpoint;
}

function main(): void {
    const numPairs = parseInt(prompt("Введите количество пар:\n") || "0", 10);

    if (isNaN(numPairs) || numPairs <= 0) {
        console.log("Некорректный ввод количества пар.");
        return;
    }

    const pairs: [string, string][] = [];
    for (let i = 0; i < numPairs; i++) {
        const input = prompt("Введите пару (начальный пункт конечный пункт):\n");
        if (!input) {
            console.log("Некорректный ввод пары. Попробуйте снова.");
            return;
        }
        const parts = input.split(" ");
        if (parts.length === 2) {
            pairs.push([parts[0], parts[1]]);
        } else {
            console.log("Некорректный ввод пары. Попробуйте снова.");
            return;
        }
    }

    // Проверка на пустые пары внутри массива.
    const filteredPairs = pairs.filter(
        (pair) => pair[0].length > 0 && pair[1].length > 0
    );

    const result = findLongestChainEndpoint(filteredPairs);
    console.log(`Итоговый конечный пункт: ${result}`);
}

main();