lines = File.readlines('./input.txt')

# Part 1
total_fuel = 0
lines.each do |mass|
  fuel = (mass.to_i / 3).floor - 2
  total_fuel += fuel
end

puts total_fuel

# Part 2
total_fuel = 0
lines.each do |mass|
  fuel = (mass.to_i / 3).floor - 2
  component_fuel = fuel

  while ((component_fuel / 3).floor - 2) > 0
    component_fuel = (component_fuel / 3).floor - 2
    fuel += component_fuel
  end

  total_fuel += fuel
end

puts total_fuel