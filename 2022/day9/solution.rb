require 'set'

lines = File.readlines('./input.txt').map(&:strip)

current_tail_coordinates = { x: 0, y: 0 }
current_head_coordinates = { x: 0, y: 0 }

tail_visited_coordinates = Set.new
tail_visited_coordinates.add(current_tail_coordinates)

def move_tail_to_head_if_necessary(head_coordinates, tail_coordinates)
  x_difference = (head_coordinates[:x] - tail_coordinates[:x]).abs
  y_difference = (head_coordinates[:y] - tail_coordinates[:y]).abs

  new_tail_coordinates = { x: tail_coordinates[:x], y: tail_coordinates[:y] }
  # diagonal move
  if x_difference > 1 && y_difference > 0 || x_difference > 0 && y_difference > 1
    if head_coordinates[:x] > tail_coordinates[:x]
      new_tail_coordinates = { x: new_tail_coordinates[:x] + 1, y: new_tail_coordinates[:y] }
    else
      new_tail_coordinates = { x: new_tail_coordinates[:x] - 1, y: new_tail_coordinates[:y] }
    end

    if head_coordinates[:y] > tail_coordinates[:y]
      new_tail_coordinates = { x: new_tail_coordinates[:x], y: new_tail_coordinates[:y] + 1 }
    else
      new_tail_coordinates = { x: new_tail_coordinates[:x], y: new_tail_coordinates[:y] - 1 }
    end
  elsif x_difference > 1
    if head_coordinates[:x] > tail_coordinates[:x]
      new_tail_coordinates = { x: new_tail_coordinates[:x] + 1, y: new_tail_coordinates[:y] }
    else
      new_tail_coordinates = { x: new_tail_coordinates[:x] - 1, y: new_tail_coordinates[:y] }
    end
  elsif y_difference > 1
    if head_coordinates[:y] > tail_coordinates[:y]
      new_tail_coordinates = { x: new_tail_coordinates[:x], y: new_tail_coordinates[:y] + 1 }
    else
      new_tail_coordinates = { x: new_tail_coordinates[:x], y: new_tail_coordinates[:y] - 1 }
    end
  end

  new_tail_coordinates
end

lines.each do |line|
  direction, spaces = line.split(' ')
  spaces = spaces.to_i

  (0..spaces - 1).each do |_|
    case direction
    when 'R'
      current_head_coordinates = { x: current_head_coordinates[:x] + 1, y: current_head_coordinates[:y] }
    when 'L'
      current_head_coordinates = { x: current_head_coordinates[:x] - 1, y: current_head_coordinates[:y] }
    when 'U'
      current_head_coordinates = { x: current_head_coordinates[:x], y: current_head_coordinates[:y] + 1 }
    when 'D'
      current_head_coordinates = { x: current_head_coordinates[:x], y: current_head_coordinates[:y] - 1 }
    else
      raise ArgumentError, "Unexpected direction: #{direction}"
    end

    current_tail_coordinates = move_tail_to_head_if_necessary(current_head_coordinates, current_tail_coordinates)
    tail_visited_coordinates.add(current_tail_coordinates)
  end
end

pp tail_visited_coordinates.size

knot_coordinates = (1..10).map do |_|
  { x: 0, y: 0 }
end

final_tail_visited_coordinates = Set.new
final_tail_visited_coordinates.add({ x: 0, y: 0 })

lines.each do |line|
  direction, spaces = line.split(' ')
  spaces = spaces.to_i

  (0..spaces - 1).each do |_|
    case direction
    when 'R'
      knot_coordinates[0] = { x: knot_coordinates.first[:x] + 1, y: knot_coordinates.first[:y] }
    when 'L'
      knot_coordinates[0] = { x: knot_coordinates.first[:x] - 1, y: knot_coordinates.first[:y] }
    when 'U'
      knot_coordinates[0] = { x: knot_coordinates.first[:x], y: knot_coordinates.first[:y] + 1 }
    when 'D'
      knot_coordinates[0] = { x: knot_coordinates.first[:x], y: knot_coordinates.first[:y] - 1 }
    else
      raise ArgumentError, "Unexpected direction: #{direction}"
    end

    knot_coordinates.each_with_index do |head_knot, index|
      next if index == knot_coordinates.size - 1
      knot_coordinates[index + 1] = move_tail_to_head_if_necessary(head_knot, knot_coordinates[index + 1])
    end

    final_tail_visited_coordinates.add(knot_coordinates[knot_coordinates.size - 1])
  end
end

puts final_tail_visited_coordinates.size