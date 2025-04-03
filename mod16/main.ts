function countUnvisitedStones(stones: number, birds: number[]): number {
    const visited: boolean[] = new Array(stones + 1).fill(false);
    for (const bird of birds) {
        for (let i = bird; i <= stones; i += bird) {
            visited[i] = true;
        }
    }
    let unvisitedCount = 0;
    for (let i = 1; i <= stones; i++) {
        if (!visited[i]) {
            unvisitedCount++;
        }
    }
    return unvisitedCount;
}

const readline = require('readline').createInterface({
    input: process.stdin,
    output: process.stdout
});

readline.question('Введите количество камней: ', (stonesInput: string) => {
    const stones = parseInt(stonesInput);
    readline.question('Введите расстояния, которые могут преодолеть птицы (через пробел): ', (birdsInput: string) => {
        const birds = birdsInput.split(' ').map(bird => parseInt(bird));
        console.log(`Количество непосещенных камней: ${countUnvisitedStones(stones, birds)}`);
        readline.close();
    });
});