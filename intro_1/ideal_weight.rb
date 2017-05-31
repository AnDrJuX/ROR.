puts "Enter your name: "
name = gets.chomp

puts "Enter your height: "
height = gets.chomp.to_i

weight = height - 110

if weight.to_i > 0
  puts "Здравствуйте #{name } ваш идеальный вес #{weight } кг. "
else
  puts "Здравствуйте #{name } Ваш вес уже оптимальный"
end