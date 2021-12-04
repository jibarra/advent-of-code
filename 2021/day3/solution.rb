lines = File.readlines('./input.txt')

bit_range = (0..11)
def count_bits_in_positions(lines, bit_range)
  bit_count_0s, bit_count_1s = [], []
  (0..lines.first.size).each do |position|
    bit_count_0s.push(0)
    bit_count_1s.push(0)
  end

  lines.each do |line|
    bit_range.each do |position|
      if line[position] == '0'
        bit_count_0s[position] += 1
      elsif line[position] == '1'
        bit_count_1s[position] += 1
      else
        raise ArgumentError, "Unexpected value"
      end
    end
  end
  [bit_count_0s, bit_count_1s]
end

# Part 1
bit_count_0s, bit_count_1s = count_bits_in_positions(lines, bit_range)

gamma_rate = bit_range.map do |position|
  if bit_count_0s[position] > bit_count_1s[position]
    '0'
  elsif bit_count_1s[position] > bit_count_0s[position]
    '1'
  else
    raise ArgumentError, "Expected all positions to be strictly greater"
  end
end.join('')

epsilon_rate = bit_range.map do |position|
  if bit_count_0s[position] < bit_count_1s[position]
    '0'
  elsif bit_count_1s[position] < bit_count_0s[position]
    '1'
  else
    raise ArgumentError, "Expected all positions to be strictly less than"
  end
end.join('')

puts Integer(gamma_rate, 2) * Integer(epsilon_rate, 2)

# Part 2
oxygen_generator_rating_binary = nil
co2_scrubber_rating_binary = nil
oxygen_generator_lines = lines
co2_scrubber_lines = lines

bit_range.each do |position|
  break if !oxygen_generator_rating_binary.nil?

  current_0_bit_count, current_1_bit_count = count_bits_in_positions(oxygen_generator_lines, bit_range)
  bit_to_select = current_1_bit_count[position] >= current_0_bit_count[position] ? '1' : '0'
  oxygen_generator_lines = oxygen_generator_lines.select do |line|
    line[position] == bit_to_select
  end

  oxygen_generator_rating_binary = oxygen_generator_lines.first if oxygen_generator_lines.size == 1
end

bit_range.each do |position|
  break if !co2_scrubber_rating_binary.nil?

  current_0_bit_count, current_1_bit_count = count_bits_in_positions(co2_scrubber_lines, bit_range)
  bit_to_select = current_1_bit_count[position] < current_0_bit_count[position] ? '1' : '0'
  co2_scrubber_lines = co2_scrubber_lines.select do |line|
    line[position] == bit_to_select
  end

  co2_scrubber_rating_binary = co2_scrubber_lines.first if co2_scrubber_lines.size == 1
end

puts Integer(oxygen_generator_rating_binary, 2) * Integer(co2_scrubber_rating_binary, 2)
