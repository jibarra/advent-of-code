# Part 1
# Could have two loops, one inside the other.
# Could also put all the numbers into something like a hash, and loop through it once.
#   Subtract the current number from 2020 and see if that result exists.

lines = File.readlines('./input.txt')
line_depths = lines.map(&:to_i)

previous_depth = nil
measurements_larger_than_last = 0
line_depths.each do |depth|
  if previous_depth && previous_depth < depth
    measurements_larger_than_last += 1
  end
  previous_depth = depth
end

puts measurements_larger_than_last

sliding_windows_larger_than_last = 0
previous_sliding_window_sum = nil
i = 0
while i < line_depths.length - 2
  current_sliding_window_sum = line_depths[i] + line_depths[i + 1] + line_depths[i + 2]
  if previous_sliding_window_sum && previous_sliding_window_sum < current_sliding_window_sum
    sliding_windows_larger_than_last += 1
  end
  previous_sliding_window_sum = current_sliding_window_sum
  i += 1
end

puts sliding_windows_larger_than_last