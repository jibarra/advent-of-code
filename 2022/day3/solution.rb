require 'set'

lines = File.readlines('./input.txt')

# Part 1

def item_in_both_compartments(compartment_1, compartment_2)
  compartment_1_items = Set.new(compartment_1.chars)
  compartment_2_items = Set.new(compartment_2.chars)

  compartment_1_items.each do |compartment_1_item|
    if compartment_2_items.include?(compartment_1_item)
      return compartment_1_item
    end
  end

  puts 'match not found'
end

def item_priority(item)
  if /[[:upper:]]/.match(item)
    item.ord - 38
  else
    item.ord - 96
  end
end

total_priority = 0
lines.each do |rucksack|
  compartment_1 = rucksack.strip[0..((rucksack.length / 2) - 1)]
  compartment_2 = rucksack.strip[(rucksack.length / 2)..-1]

  item_in_both = item_in_both_compartments(compartment_1, compartment_2)
  total_priority += item_priority(item_in_both)
end

puts total_priority
