lines = File.readlines('./input.txt')

lines.map(&:strip)

# Part 1
def ranges_have_coverage?(first_range, second_range)
  # Could be replaced by first_range.cover?(second_range) in Ruby 3

  if first_range.first <= second_range.first && first_range.last >= second_range.last
    true
  elsif second_range.first <= first_range.first && second_range.last >= first_range.last
    true
  else
    false
  end
end

# Part 2
def ranges_overlap?(first_range, second_range)
  if ranges_have_coverage?(first_range, second_range)
    true
  elsif second_range.cover?(first_range.first)
    true
  elsif second_range.cover?(first_range.last)
    true
  elsif first_range.cover?(second_range.first)
    true
  elsif first_range.cover?(second_range.last)
    true
  else
    false
  end
end

full_coverage_pair_count = 0
any_overlap_count = 0
lines.each do |line|
  pair = line.split(',')
  first_sections = pair[0].split('-').map(&:to_i)
  second_sections = pair[1].split('-').map(&:to_i)

  first_range = (first_sections.first..first_sections[1])
  second_range = (second_sections.first..second_sections[1])

  if ranges_have_coverage?(first_range, second_range)
    full_coverage_pair_count += 1
  end

  if ranges_overlap?(first_range, second_range)
    any_overlap_count += 1
  end
end

puts full_coverage_pair_count
puts any_overlap_count
