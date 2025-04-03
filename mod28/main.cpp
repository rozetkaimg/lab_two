#include <iostream>
#include <vector>
#include <sstream>
#include <string>

int countNumbersWithSumGreaterThan10(const std::vector<int>& numbers) {
    int count = 0;
    for (int number : numbers) {
        int sum = 0;
        int temp = number;
        while (temp > 0) {
            sum += temp % 10;
            temp /= 10;
        }
        if (sum > 10) {
            count++;
        }
    }
    return count;
}

int main() {
    std::cout << "Введите список чисел, разделенных пробелами: ";
    std::string input;
    std::getline(std::cin, input);

    std::vector<int> numbers;
    std::stringstream ss(input);
    std::string numStr;
    while (ss >> numStr) {
        try {
            int num = std::stoi(numStr);
            numbers.push_back(num);
        } catch (const std::invalid_argument& e) {
            std::cerr << "Некорректный ввод: " << numStr << ". Это значение будет пропущено." << std::endl;
        } catch (const std::out_of_range& e) {
            std::cerr << "Некорректный ввод: " << numStr << ". Это значение будет пропущено." << std::endl;
        }
    }

    int result = countNumbersWithSumGreaterThan10(numbers);
    std::cout << "Количество чисел с суммой цифр > 10: " << result << std::endl;

    return 0;
}