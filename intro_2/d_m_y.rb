print "Введите число: "
day = gets.chomp.to_i

print "Введите месяц: "
month = gets.chomp.to_i

print "Введите год: "
year = gets.chomp.to_i

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
  months[1] = 29
end

if month == 1
  puts day
else
  num = months.take(month - 1).inject(:+) + day
  puts "Порядковый номер дня с начала года: #{num}"
end



