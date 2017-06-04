arr = [0, 1]
a = 0

while a <= 100
  a = arr[arr.length - ((arr[2].to_i / 2) + 1)] + arr.last
  arr << a
end

puts arr
#144