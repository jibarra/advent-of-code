lines = File.readlines('./input.txt')

count_double = 0
count_triple = 0

lines.each do |line|
  sorted_line = line.strip.chars.sort.join

  doubles = 0
  triples = 0
  count = 0
  char = ''
  sorted_line.split('').each do |c|
    if char != c
      doubles += 1 if count == 2
      triples += 1 if count == 3
      char = c
      count = 1
    else
      count += 1
    end
  end

  # don't miss the last character
  doubles += 1 if count == 2
  triples += 1 if count == 3

  count_double += 1 if doubles > 0
  count_triple += 1 if triples > 0
  puts sorted_line
  puts doubles
  puts triples
end

puts count_double
puts count_triple
puts (count_double * count_triple)