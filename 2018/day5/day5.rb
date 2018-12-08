require 'pry'

lines = File.readlines('./input.txt')

polymer = lines[0].strip


def react_polymer(polymer, skip_character= ' ')
  poly = polymer.dup
  alpha = ('a'..'z').to_a
  old_polymer = nil
  while old_polymer != poly do
    old_polymer = poly.dup

    alpha.each do |c|
      poly.gsub!(c + c.upcase, '')
      poly.gsub!(c.upcase + c, '')
    end
  end
  poly
end

def react_problem_polymer(polymer)
  alpha = ('a'..'z').to_a
  problem_polymers = []
  alpha.each do |c|
    poly = polymer.dup
    poly.gsub!(c, '')
    poly.gsub!(c.upcase, '')
    poly = react_polymer(poly, c)
    problem_polymers << { character: c, size: poly.size }
  end
  problem_polymers
end

part_1 = react_polymer(polymer)

puts part_1.size

part_2 = react_problem_polymer(polymer)
lowest = 100000000
part_2.each do |poly|
  lowest = poly[:size] if poly[:size] < lowest
end
puts lowest