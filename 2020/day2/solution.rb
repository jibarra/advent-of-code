lines = File.readlines('./input.txt')

def get_policy(line)
  split_line = line.split(' ')

  # Number of times the character can appear
  numbers_in_policy = split_line[0].split('-')
  num_1 = numbers_in_policy[0].to_i
  num_2 = numbers_in_policy[1].to_i

  # The character we expect to appear according to the count rules
  char = split_line[1].gsub(':', '')

  # The password
  password = split_line[2]

  [num_1, num_2, char, password]
end

# Part 1
valid_passwords = lines.select do |line|
  min_char_count, max_char_count, char, password = get_policy(line)

  actual_char_count = password.scan(char).length

  min_char_count <= actual_char_count && max_char_count >= actual_char_count
end

puts valid_passwords.count

# Part 2
valid_passwords = lines.select do |line|
  char_position_1, char_position_2, char, password = get_policy(line)

  # Modify char positions (the policy is 1 indexed)
  char_position_1 = char_position_1 - 1
  char_position_2 = char_position_2 - 1

  if password[char_position_1] == char && password[char_position_2] != char
    true
  elsif password[char_position_1] != char && password[char_position_2] == char
    true
  else
    false
  end
end

puts valid_passwords.count
