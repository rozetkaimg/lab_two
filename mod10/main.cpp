#include <iostream>
#include <vector>
#include <map>
#include <string>

using namespace std;

string findLongestChainEndpoint(const vector<pair<string, string>>& pairs) {
    if (pairs.empty()) {
        return "Нет пар для анализа";
    }

    map<string, string> graph;
    for (const auto& pair : pairs) {
        if (pair.first == pair.second) {
            return "обратитесь к специалисту";
        }
        graph[pair.first] = pair.second;
    }

    string longestChainEndpoint = "";
    int maxLength = 0;

    for (const auto& start : graph) {
        string current = start.first;
        int length = 1;
        while (graph.count(current)) {
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

int main() {
    cout << "Введите количество пар:" << endl;
    int numPairs;
    cin >> numPairs;

    if (numPairs <= 0) {
        cout << "Некорректный ввод количества пар." << endl;
        return 0;
    }

    vector<pair<string, string>> pairs(numPairs);
    cin.ignore(); // Очистить буфер после ввода числа

    for (int i = 0; i < numPairs; ++i) {
        cout << "Введите пару (начальный пункт конечный пункт):" << endl;
        string input;
        getline(cin, input);

        size_t spacePos = input.find(' ');
        if (spacePos != string::npos) {
            pairs[i] = make_pair(input.substr(0, spacePos), input.substr(spacePos + 1));
        } else {
            cout << "Некорректный ввод пары. Попробуйте снова." << endl;
            return 0;
        }
    }

    // Проверка на пустые пары внутри массива.
    vector<pair<string, string>> filteredPairs;
    for (const auto& pair : pairs) {
        if (!pair.first.empty() && !pair.second.empty()) {
            filteredPairs.push_back(pair);
        }
    }

    string result = findLongestChainEndpoint(filteredPairs);
    cout << "Итоговый конечный пункт: " << result << endl;

    return 0;
}