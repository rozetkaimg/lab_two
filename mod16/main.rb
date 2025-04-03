def count_unvisited_stones(stones, birds)
  visited = [false] * (stones + 1) # Создаем массив для отслеживания посещенных камней.
  birds.each do |bird| # Перебираем каждую птицу.
    (bird..stones).step(bird).each do |i| # Перебираем камни, которые может посетить птица.
      visited[i] = true # Помечаем камень как посещенный.
    end
  end
  (1..stones).count { |i| !visited[i] } # Подсчитываем количество непосещенных камней.
end

print "Введите количество камней: "
stones = gets.chomp.to_i # Получаем общее количество камней от пользователя.

print "Введите расстояния, которые могут преодолеть птицы (через пробел): "
birds = gets.chomp.split(" ").map(&:to_i) # Получаем расстояния, которые могут преодолевать птицы, от пользователя.

puts "Количество непосещенных камней: #{count_unvisited_stones(stones, birds)}" # Выводим результат.