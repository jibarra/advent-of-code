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
