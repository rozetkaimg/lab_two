import java.util.*;

public class LongestChain {

    public static String findLongestChainEndpoint(List<Pair<String, String>> pairs) {
        if (pairs.isEmpty()) {
            return "Нет пар для анализа";
        }

        Map<String, String> graph = new HashMap<>();
        for (Pair<String, String> pair : pairs) {
            if (pair.getKey().equals(pair.getValue())) {
                return "обратитесь к специалисту";
            }
            graph.put(pair.getKey(), pair.getValue());
        }

        String longestChainEndpoint = "";
        int maxLength = 0;

        for (String start : graph.keySet()) {
            String current = start;
            int length = 1;
            while (graph.containsKey(current)) {
                current = graph.get(current);
                length++;
            }

            if (length > maxLength) {
                maxLength = length;
                longestChainEndpoint = current;
            }
        }

        return longestChainEndpoint;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.println("Введите количество пар:");
        int numPairs = scanner.nextInt();
        scanner.nextLine(); // Consume newline

        if (numPairs <= 0) {
            System.out.println("Некорректный ввод количества пар.");
            return;
        }

        List<Pair<String, String>> pairs = new ArrayList<>();
        for (int i = 0; i < numPairs; i++) {
            System.out.println("Введите пару (начальный пункт конечный пункт):");
            String input = scanner.nextLine();
            String[] parts = input.split(" ");
            if (parts.length == 2) {
                pairs.add(new Pair<>(parts[0], parts[1]));
            } else {
                System.out.println("Некорректный ввод пары. Попробуйте снова.");
                return;
            }
        }

        // Проверка на пустые пары внутри массива.
        List<Pair<String, String>> filteredPairs = new ArrayList<>();
        for (Pair<String, String> pair : pairs) {
            if (pair.getKey() != null && !pair.getKey().isEmpty() && pair.getValue() != null && !pair.getValue().isEmpty()) {
                filteredPairs.add(pair);
            }
        }

        String result = findLongestChainEndpoint(filteredPairs);
        System.out.println("Итоговый конечный пункт: " + result);
    }

    static class Pair<K, V> {
        private K key;
        private V value;

        public Pair(K key, V value) {
            this.key = key;
            this.value = value;
        }

        public K getKey() {
            return key;
        }

        public V getValue() {
            return value;
        }
    }
}