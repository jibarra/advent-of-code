lines = File.readlines('./input.txt')

separating_line = lines.find_index { |line| line.strip.empty? }

stack_count = lines[separating_line - 1].split(' ').last.to_i

stacks = (0..stack_count - 1).map do |stack_index|
  []
end

(0..(separating_line - 2)).each do |line_number|
  line_index = 1
  (0..(stack_count - 1)).each do |stack_index|
    if !lines[line_number][line_index].strip.empty?
      stacks[stack_index].unshift(lines[line_number][line_index])
    end
    line_index += 4
  end
end

part_2_stacks = stacks.map { |stack| stack.dup }

instructions = lines[separating_line + 1..-1].map(&:strip)

instructions.each do |instruction|
  stack_instructions = instruction.scan(/\d+/).map(&:to_i)
  quantity_to_move = stack_instructions[0]
  stack_to_move_from = stacks[stack_instructions[1] - 1]
  stack_to_move_to = stacks[stack_instructions[2] - 1]

  (0..quantity_to_move - 1).each do |_|
    item_to_move = stack_to_move_from.pop
    if item_to_move
      stack_to_move_to.push(item_to_move)
    end
  end
end

top_of_stack = ''
stacks.each do |stack|
  top_of_stack = top_of_stack + (stack.last || '')
end

# Part 1
pp top_of_stack

# Part 2
instructions.each do |instruction|
  stack_instructions = instruction.scan(/\d+/).map(&:to_i)
  quantity_to_move = stack_instructions[0]
  stack_to_move_from = part_2_stacks[stack_instructions[1] - 1]
  stack_to_move_to = part_2_stacks[stack_instructions[2] - 1]

  items_to_move = stack_to_move_from.pop(quantity_to_move).compact
  stack_to_move_to.push(*items_to_move)
end


top_of_stack = ''
part_2_stacks.each do |stack|
  top_of_stack = top_of_stack + (stack.last || '')
end

pp top_of_stack