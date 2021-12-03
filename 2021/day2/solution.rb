lines = File.readlines('./input.txt')

# Part 1
horizontal_position = 0
depth = 0
lines.each do |line|
  instruction, amount = line.split(' ')
  amount = Integer(amount)
  if instruction == 'forward'
    horizontal_position += amount
  elsif instruction == 'down'
    depth += amount
  elsif instruction == 'up'
    depth -= amount
  else
    raise ArgumentError, "Unexpected instruction #{instruction}"
  end
end

puts horizontal_position * depth

# Part 2
horizontal_position = 0
depth = 0
aim = 0
lines.each do |line|
  instruction, amount = line.split(' ')
  amount = Integer(amount)
  if instruction == 'forward'
    horizontal_position += amount
    depth += amount * aim
  elsif instruction == 'down'
    aim += amount
  elsif instruction == 'up'
    aim -= amount
  else
    raise ArgumentError, "Unexpected instruction #{instruction}"
  end
end

puts horizontal_position * depth
