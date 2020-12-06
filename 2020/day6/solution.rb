require 'rb-readline'
require 'pry'
require 'set'

lines = File.readlines('./input.txt')

# Part 1
group_answers = Set.new
sum_yes_count = 0

lines.each do |line|
  line = line.strip
  if line.empty?
    sum_yes_count += group_answers.size
    group_answers = Set.new
  else
    line.split('').each do |answer|
      group_answers.add(answer)
    end
  end
end

sum_yes_count += group_answers.size
puts sum_yes_count

# Part 2
group_answers = Hash.new(0)
group_size = 0
sum_yes_count = 0

lines.each do |line|
  line = line.strip
  if line.empty?
    group_answers.each do |key, value|
      sum_yes_count += 1 if value == group_size
    end
    group_answers = Hash.new(0)
    group_size = 0
  else
    group_size += 1
    line.split('').each do |answer|
      group_answers[answer] += 1
    end
  end
end

group_answers.each do |key, value|
  sum_yes_count += 1 if value == group_size
end

puts sum_yes_count
