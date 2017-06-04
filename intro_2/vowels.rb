vowels = %w[a e i o u y]
all = ("a".."z").to_a
hash = {}

vowels.each do |l|
  if all.include? l
    hash[l] = all.index(l) + 1
  end
end
puts hash