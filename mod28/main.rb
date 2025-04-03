def count_numbers_with_sum_greater_than_10(numbers)
    count = 0
    numbers.each do |number|
      sum = 0
      temp = number
      while temp > 0
        sum += temp % 10
        temp /= 10
      end
      count += 1 if sum > 10
    end
    count
  end
  
  print 'Введите список чисел, разделенных пробелами: '
  input = gets.chomp
  input_numbers = input.split(' ')
  
  numbers = []
  input_numbers.each do |num_str|
    num = num_str.to_i
    unless num.zero? && num_str != '0' # Проверка на некорректный ввод
      numbers << num
    else
      puts "Некорректный ввод: #{num_str}. Это значение будет пропущено."
    end
  end
  
  result = count_numbers_with_sum_greater_than_10(numbers)
  puts "Количество чисел с суммой цифр > 10: #{result}"