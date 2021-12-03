lines = File.readlines('./input.txt')
line_depths = lines.map(&:to_i)

# Part 1
previous_depth = nil
measurements_larger_than_last = 0
line_depths.each do |depth|
  if previous_depth && previous_depth < depth
    measurements_larger_than_last += 1
  end
  previous_depth = depth
end

puts measurements_larger_than_last

# Part 2
sliding_windows_larger_than_last = 0
line_depths.each_cons(4) do |measurements|
  first_sliding_window = measurements[0] + measurements[1] + measurements[2]
  second_sliding_window = measurements[1] + measurements[2] + measurements[3]

  if first_sliding_window < second_sliding_window
    sliding_windows_larger_than_last += 1
  end
end

puts sliding_windows_larger_than_last
