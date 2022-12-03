lines = File.readlines('./input.txt')

# Part 1
total_calories = []
current_elf_calories = 0

lines.each do |line|
  if line.strip.empty?
    total_calories.push(current_elf_calories)
    current_elf_calories = 0
  else
    item_calories = Integer(line, 10)
    current_elf_calories += item_calories
  end
end

total_calories.push(current_elf_calories)
max_calories = total_calories.max
puts max_calories

# Part 2
highest_max_calories = max_calories
total_calories.delete(max_calories)

max_calories = total_calories.max
second_highest_max_calories = max_calories
total_calories.delete(max_calories)

max_calories = total_calories.max
third_highest_max_calories = max_calories

puts highest_max_calories + second_highest_max_calories + third_highest_max_calories