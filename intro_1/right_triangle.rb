side = []
puts "Введите сторону a: "
side[0] = gets.chomp

puts "Введите сторону b: "
side[1] = gets.chomp

puts "Введите сторону c: "
side[2] = gets.chomp
storonq = side.sort

if storonq[0] == storonq[1] && storonq[0] == storonq[2]
  puts "Треугольник не прямоугольный, он равносторонний и равнобедренный."
elsif storonq[0] == storonq[1]
  puts "Треугольник равнобедеренный."
elsif storonq[2]**2 == storonq[0]**2 + storonq[1]**2
  puts "Треугольник прямоугольный"
else
  puts "Треугольник не прямоугольный."
end