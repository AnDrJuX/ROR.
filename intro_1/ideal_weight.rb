puts "Enter your name: "
name = gets.chomp

puts "Enter your height: "
height = gets.chomp

weight = height.to_i - 110



if weight.to_i > 0
  puts "Здравствуйте #{name } ваш идеальный вес #{weight } кг. "
else
  puts "Здравствуйте #{name } Ваш вес уже оптимальный"
end





