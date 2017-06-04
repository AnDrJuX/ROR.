vowels = %w[a e i o u y]
all = ("a".."z").to_a
hash = {}

i = 0

vowels.each do |l|
  if all.include? l
    hash["#{vowels[i]}"] = "#{all.index(l)+1}"
    i += 1
  end
end
puts hash