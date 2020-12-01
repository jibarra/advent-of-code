# Part 1
# Could have two loops, one inside the other.
# Could also put all the numbers into something like a hash, and loop through it once.
#   Subtract the current number from 2020 and see if that result exists.

require 'set'

lines = File.readlines('./input.txt').map(&:to_i)
numbers = lines.each_with_object(Set.new) { |num, memo| memo.add(num) }
summed_number = 2020

numbers_with_matches = numbers.select do |num|
  other_potential_entry = summed_number - num
  numbers.include?(other_potential_entry)
end

puts numbers_with_matches
puts numbers_with_matches.inject(:*)
  