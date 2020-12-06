require 'rb-readline'
require 'pry'

lines = File.readlines('./input.txt')

# Part 1
def find_correct_index(partitions, lower_indicator, higher_indicator, max_value)
  min = 0
  max = max_value

  partitions.split('').each do |partition|
    # integer division
    max_of_min_range = min + ((max - min) / 2)
    if partition == lower_indicator
      max = max_of_min_range
    elsif partition == higher_indicator
      min = max_of_min_range + 1
    else
      raise "Received different row partition: #{partition}"
    end
  end

  min
end

seat_ids = []
lines.each do |line|
  row_partitions = line[0..6]
  column_partitions = line[7..-2]

  row = find_correct_index(row_partitions, 'F', 'B', 127)
  column = find_correct_index(column_partitions, 'L', 'R', 7)

  seat_ids << (row * 8) + column
end

puts seat_ids.max

# Part 2
sorted_seat_ids = seat_ids.sort
unassigned_seats = []

sorted_seat_ids.each do |seat_id|
  lower_seat_id = seat_id - 1
  higher_seat_id = seat_id + 1

  if !sorted_seat_ids.include?(lower_seat_id) && sorted_seat_ids.include?(lower_seat_id - 1)
    unassigned_seats.push(lower_seat_id)
  end
  if !sorted_seat_ids.include?(higher_seat_id) && sorted_seat_ids.include?(higher_seat_id + 1)
    unassigned_seats.push(higher_seat_id)
  end
end

puts unassigned_seats
