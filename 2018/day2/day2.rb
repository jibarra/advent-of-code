require 'set'

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
end

puts (count_double * count_triple)

# Hold all possible "one letter removed" ids
similar_ids = Set.new
common_letters = ''

lines.each do |line|
  clean_line = line.strip
  # Don't add strings immediately; may cause false positives if current string has doubles next to eachother
  similar_ids_to_add = Set.new

  (0..clean_line.size - 1).each do |n|
    delete_one = clean_line.slice(0, n) + clean_line.slice(n + 1, clean_line.size)
    common_letters = delete_one if similar_ids.include?(delete_one)
    similar_ids_to_add.add(delete_one)
  end

  similar_ids.merge(similar_ids_to_add)
end

puts common_letters
