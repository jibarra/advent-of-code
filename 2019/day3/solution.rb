require 'set'
lines = File.readlines('./input.txt')

first_wire_path = lines[0].split(',')
second_wire_path = lines[1].split(',')

# large 2d array? (likely inefficient)
# calculate lines (y = mx + b) for the different parts?
# Find the different points that each path covers and compare?

def wire_points(wire_path)
  starting_x = 0
  starting_y = 0
  steps = 0

  wire_path.each_with_object(Hash.new()) do |path, memo|
    direction = path[0]
    amount = path[1..-1].to_i

    case direction
    when 'U'
      (1..amount).each do |a| 
        starting_y += 1
        steps += 1
        memo["#{starting_x},#{starting_y}"] = steps
      end
    when 'D'
      (1..amount).each do |a| 
        starting_y -= 1
        steps += 1
        memo["#{starting_x},#{starting_y}"] = steps
      end
    when 'L'
      (1..amount).each do |a| 
        starting_x -= 1
        steps += 1
        memo["#{starting_x},#{starting_y}"] = steps
      end
    when 'R'
      (1..amount).each do |a| 
        starting_x += 1
        steps += 1
        memo["#{starting_x},#{starting_y}"] = steps
      end
    else
      raise ArgumentError('No direction')
    end
  end
end

# Part 1
first_wire_points = wire_points(first_wire_path)
second_wire_points = wire_points(second_wire_path)

matches = first_wire_points.select { |point| second_wire_points.include?(point)}
distances = matches.map do |match, steps|
  split = match.split(',')
  # calculate the manhattan distance
  split[0].to_i.abs + split[1].to_i.abs
end

min_distance = distances.min
puts min_distance

# Part 2
steps = matches.map do |match, steps|
  second_steps = second_wire_points[match]
  steps + second_steps
end

min_steps = steps.min
puts min_steps
