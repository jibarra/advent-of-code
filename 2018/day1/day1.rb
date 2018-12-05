require 'set'

lines = File.readlines('./input.txt')

frequency = 0
lines.each do |f|
  frequency += f.to_i
end

puts frequency

frequency = 0
visited_frequencies = Set.new
i = 0

while !visited_frequencies.include?(frequency)
  visited_frequencies.add(frequency)
  frequency += lines[i].to_i
  i = (i + 1) % lines.size
end

puts i
puts lines.size
puts frequency
