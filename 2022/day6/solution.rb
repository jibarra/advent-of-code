lines = File.readlines('./input.txt')
line = lines.first

# Part 1
current_packet = []
current_index = 0

line.chars.each do |char|
  current_packet[current_index % 4] = char

  if current_packet.size == 4 && current_packet.uniq.size == 4
    break
  end

  current_index += 1
end

pp current_index + 1

# Part 2
current_message = []
current_index = 0

line.chars.each do |char|
  current_message[current_index % 14] = char
  if current_message.size == 14 && current_message.uniq.size == 14
    break
  end

  current_index += 1
end

pp current_index + 1