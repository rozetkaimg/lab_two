def find_longest_chain_endpoint(pairs):
    if not pairs:
        return "Нет пар для анализа"

    graph = {}
    for pair in pairs:
        if pair[0] == pair[1]:
            return "обратитесь к специалисту"
        graph[pair[0]] = pair[1]

    longest_chain_endpoint = ""
    max_length = 0

    for start in graph:
        current = start
        length = 1
        while current in graph:
            current = graph[current]
            length += 1

        if length > max_length:
            max_length = length
            longest_chain_endpoint = current

    return longest_chain_endpoint

def main():
    num_pairs = int(input("Введите количество пар:\n"))

    if num_pairs <= 0:
        print("Некорректный ввод количества пар.")
        return

    pairs = []
    for _ in range(num_pairs):
        input_str = input("Введите пару (начальный пункт конечный пункт):\n")
        parts = input_str.split()
        if len(parts) == 2:
            pairs.append(parts)
        else:
            print("Некорректный ввод пары. Попробуйте снова.")
            return

    # Проверка на пустые пары внутри массива.
    filtered_pairs = [pair for pair in pairs if pair[0] and pair[1]]

    result = find_longest_chain_endpoint(filtered_pairs)
    print(f"Итоговый конечный пункт: {result}")

if __name__ == "__main__":
    main()