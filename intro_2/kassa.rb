cart = {}

loop do
  total = 0
  puts "Если хотите закончить введите stop. Введите название товара: "
  item_name = gets.chomp
  break if item_name == "stop"

  puts "Цену за единицу: "
  item_price = gets.chomp.to_f

  puts "Kол-во купленного товара: "
  item_size = gets.chomp.to_f

  cart[item_name] = { item_price => item_size }

  sum = item_price * item_size

  cart.each_value do |value|
    value.each_pair { |k, v| total += k * v }
  end

  puts "Ваша корзина содержит: #{cart}"
  puts "сумма за товар:  #{item_name}: #{sum} eur"
  puts "Итоговая сумма за все товары: #{total} eur"

end