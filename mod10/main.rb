def find_longest_chain_endpoint(pairs)
  if pairs.empty?
    return "Нет пар для анализа"
  end

  graph = {}
  pairs.each do |pair|
    if pair[0] == pair[1]
      return "обратитесь к специалисту"
    end
    graph[pair[0]] = pair[1]
  end

  longest_chain_endpoint = ""
  max_length = 0

  graph.keys.each do |start|
    current = start
    length = 1
    while graph.key?(current)
      current = graph[current]
      length += 1
    end

    if length > max_length
      max_length = length
      longest_chain_endpoint = current
    end
  end

  return longest_chain_endpoint
end

def main
  print "Введите количество пар:\n"
  num_pairs = gets.chomp.to_i

  if num_pairs <= 0
    puts "Некорректный ввод количества пар."
    return
  end

  pairs = []
  num_pairs.times do
    print "Введите пару (начальный пункт конечный пункт):\n"
    input = gets.chomp
    parts = input.split(" ")
    if parts.length == 2
      pairs << parts
    else
      puts "Некорректный ввод пары. Попробуйте снова."
      return
    end
  end

  # Проверка на пустые пары внутри массива.
  filtered_pairs = pairs.select { |pair| !pair[0].empty? && !pair[1].empty? }

  result = find_longest_chain_endpoint(filtered_pairs)
  puts "Итоговый конечный пункт: #{result}"
end

main