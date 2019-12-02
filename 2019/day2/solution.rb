lines = File.readlines('./input.txt')
first_line = lines.first

# Part 1
positions = first_line.split(',').map(&:to_i)

# Replace position 1 and 2
positions[1] = 12
positions[2] = 2

current_opcode = 0

while positions[current_opcode] != 99
  # add
  if positions[current_opcode] == 1
    input_position_1 = positions[current_opcode + 1]
    input_position_2 = positions[current_opcode + 2]
    output_position = positions[current_opcode + 3]
    positions[output_position] = positions[input_position_1] + positions[input_position_2]
  # multiply
  elsif positions[current_opcode] == 2
    input_position_1 = positions[current_opcode + 1]
    input_position_2 = positions[current_opcode + 2]
    output_position = positions[current_opcode + 3]
    positions[output_position] = positions[input_position_1] * positions[input_position_2]
  end
  current_opcode += 4
end

puts positions[0]

# Part 2

def run_program(memory, memory_overwrite_1, memory_overwrite_2)
  memory[1] = memory_overwrite_1
  memory[2] = memory_overwrite_2
  current_opcode = 0

  while memory[current_opcode] != 99
    # add
    if memory[current_opcode] == 1
      input_position_1 = memory[current_opcode + 1]
      input_position_2 = memory[current_opcode + 2]
      output_position = memory[current_opcode + 3]
      memory[output_position] = memory[input_position_1] + memory[input_position_2]
    # multiply
    elsif memory[current_opcode] == 2
      input_position_1 = memory[current_opcode + 1]
      input_position_2 = memory[current_opcode + 2]
      output_position = memory[current_opcode + 3]
      memory[output_position] = memory[input_position_1] * memory[input_position_2]
    end
    current_opcode += 4
  end
end

target_output = 19690720

for noun in 0..99
  for verb in 0..99
    memory = first_line.split(',').map(&:to_i)
    run_program(memory, noun, verb)
    puts (100 * noun + verb) if memory[0] == target_output
  end
end
