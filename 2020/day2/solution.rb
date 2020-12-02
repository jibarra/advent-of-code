lines = File.readlines('./input.txt')

# Part 1

valid_passwords = lines.select do |line|
  split_line = line.split(' ')

  # Number of times the character can appear
  char_count = split_line[0].split('-')
  min_char_count = char_count[0].to_i
  max_char_count = char_count[1].to_i

  # The character we expect to appear according to the count rules
  char = split_line[1].gsub(':', '')

  # The password
  password = split_line[2]

  actual_char_count = password.scan(char).length

  min_char_count <= actual_char_count && max_char_count >= actual_char_count
end

puts valid_passwords.count