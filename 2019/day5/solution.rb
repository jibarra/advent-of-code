# Opcode, Parameters
# add: 1 read_position_1 read_position_2 save_position
# multiply: 2 read_position_1 read_position_2 save_position
# input: 3 store_position
# output: 4 store_position

# Parameter mode
# Position mode: 0, parameters read as position (memory)
# Immediate mode: 1, parameters read as value

# Parameter mode stored in same position as opcode
# Opcode is right 2 most numbers
# Parameter modes are single digits, one per parameter read right to left
# e.g. parameter mode of first parameter is third from right
# Missing modes are 0
# Write parameters will never be in immediate mode.

# Output instruction from tests indicates how far result was from expected value
# 0 means successful
# If outputs are all 0 except the diagnostic program, it ran successfully

def opcode(value)
  digits = value.digits

  if digits.size < 1
    raise ("Opcode parse issue #{value}")
  end

  if digits.size == 1
    digits[0]
  else
    code = digits[0] + digits[1] * 10
  end
end

def parameter_count(opcode)
  case opcode
  when 1
    3
  when 2
    3
  when 3
    1
  when 4
    1
  when 5
    2
  when 6
    2
  when 7
    3
  when 8
    3
  else
    raise ("Invalid opcode #{opcode}")
  end
end

def parameter_modes(value, parameter_count)
  digits = value.digits

  if digits.size < 1
    raise ("Parameter mode parse issue #{value}, #{parameter_count}")
  end

  if digits.size < 3
    given_parameters = []
  else
    given_parameters = digits[2..-1]
  end

  (0...parameter_count).map do |i|
    if given_parameters.size < i + 1
      0
    else
      given_parameters[i]
    end
  end
end

def run_program(positions, input)
  current_opcode = 0
  outputs = []
  while positions[current_opcode] != 99
    instruction = positions[current_opcode]
    code = opcode(instruction)
    param_count = parameter_count(code)
    modes = parameter_modes(instruction, param_count)

    case code
    # add
    when 1
      param_1 = positions[current_opcode + 1]
      param_2 = positions[current_opcode + 2]
      output_position = positions[current_opcode + 3]

      num_1 = modes[0] == 1 ? param_1 : positions[param_1]
      num_2 = modes[1] == 1 ? param_2 : positions[param_2]
      positions[output_position] = num_1 + num_2
      current_opcode += param_count + 1
    # multiply
    when 2
      param_1 = positions[current_opcode + 1]
      param_2 = positions[current_opcode + 2]
      output_position = positions[current_opcode + 3]

      num_1 = modes[0] == 1 ? param_1 : positions[param_1]
      num_2 = modes[1] == 1 ? param_2 : positions[param_2]
      positions[output_position] = num_1 * num_2
      current_opcode += param_count + 1
    # input
    when 3
      output_position = positions[current_opcode + 1]
      positions[output_position] = input
      current_opcode += param_count + 1
    # output
    when 4
      output_param = positions[current_opcode + 1]
      output_value = modes[0] == 1 ? output_param : positions[output_param]
      outputs << output_value
      current_opcode += param_count + 1
    # jump if true
    when 5
      param_1 = positions[current_opcode + 1]
      param_2 = positions[current_opcode + 2]
      compare_value = modes[0] == 1 ? param_1 : positions[param_1]
      jump_position = modes[1] == 1 ? param_2 : positions[param_2]

      if compare_value != 0
        current_opcode = jump_position
      else
        current_opcode += param_count + 1
      end
    # jump if false
    when 6
      param_1 = positions[current_opcode + 1]
      param_2 = positions[current_opcode + 2]
      compare_value = modes[0] == 1 ? param_1 : positions[param_1]
      jump_position = modes[1] == 1 ? param_2 : positions[param_2]
      if compare_value == 0
        current_opcode = jump_position
      else
        current_opcode += param_count + 1
      end
    # less than
    when 7
      param_1 = positions[current_opcode + 1]
      param_2 = positions[current_opcode + 2]
      output_position = positions[current_opcode + 3]

      num_1 = modes[0] == 1 ? param_1 : positions[param_1]
      num_2 = modes[1] == 1 ? param_2 : positions[param_2]
      store_value = num_1 < num_2 ? 1 : 0
      positions[output_position] = store_value

      current_opcode += param_count + 1
    # equals
    when 8
      param_1 = positions[current_opcode + 1]
      param_2 = positions[current_opcode + 2]
      output_position = positions[current_opcode + 3]

      num_1 = modes[0] == 1 ? param_1 : positions[param_1]
      num_2 = modes[1] == 1 ? param_2 : positions[param_2]
      store_value = num_1 == num_2 ? 1 : 0
      positions[output_position] = store_value

      current_opcode += param_count + 1
    else
      raise ("Invalid code #{code}")
    end
  end

  outputs
end

def test
  puts 'opcode'
  puts opcode(3) == 3
  puts opcode(99) == 99
  puts opcode(103) == 3
  puts opcode(9999) == 99
  puts opcode(1002) == 2

  puts 'parameter count'
  puts parameter_count(1) == 3
  puts parameter_count(2) == 3
  puts parameter_count(3) == 1
  puts parameter_count(4) == 1
  puts parameter_count(5) == 2
  puts parameter_count(6) == 2
  puts parameter_count(7) == 3
  puts parameter_count(8) == 3

  puts 'parameter modes'
  puts parameter_modes(3, 1) == [0]
  puts parameter_modes(33, 1) == [0]
  puts parameter_modes(133, 1) == [1]
  puts parameter_modes(1011, 3) == [0, 1, 0]
  puts parameter_modes(1002, 3) == [0, 1, 0]
  puts parameter_modes(8, 3) == [0, 0, 0]

  # Simple tests
  puts 'simple tests'
  program = '3,0,4,0,99'.split(',').map(&:to_i)
  puts run_program(program.dup, 1) == [1]
  puts run_program(program.dup, 100) == [100]
  program = '1002,4,3,4,33'.split(',').map(&:to_i)
  puts run_program(program.dup, 1) == []

  # comparison tests
  # output 1 if input equal to 8, 0 otherwise (position mode)
  puts 'comparison tests'
  program = '3,9,8,9,10,9,4,9,99,-1,8'.split(',').map(&:to_i)
  puts run_program(program.dup, 8) == [1]
  puts run_program(program.dup, -5) == [0]
  puts run_program(program.dup, 100) == [0]
  # output 1 if input less than 8, 0 otherwise (position mode)
  program = '3,9,7,9,10,9,4,9,99,-1,8'.split(',').map(&:to_i)
  puts run_program(program.dup, 8) == [0]
  puts run_program(program.dup, 7) == [1]
  puts run_program(program.dup, -5) == [1]
  puts run_program(program.dup, 100) == [0]
  # output 1 if input equal to 8, 0 otherwise (immediate mode)
  program = '3,3,1108,-1,8,3,4,3,99'.split(',').map(&:to_i)
  puts run_program(program.dup, 8) == [1]
  puts run_program(program.dup, 7) == [0]
  puts run_program(program.dup, -5) == [0]
  puts run_program(program.dup, 100) == [0]
  # output 1 if input less than 8, 0 otherwise (immediate mode)
  program = '3,3,1107,-1,8,3,4,3,99'.split(',').map(&:to_i)
  puts run_program(program.dup, 8) == [0]
  puts run_program(program.dup, 7) == [1]
  puts run_program(program.dup, -5) == [1]
  puts run_program(program.dup, 100) == [0]

  # jump tests
  # output 0 if input 0, 1 if input non-zero
  puts 'jump tests'
  program = '3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9'.split(',').map(&:to_i)
  puts run_program(program.dup, 0) == [0]
  puts run_program(program.dup, -1) == [1]
  puts run_program(program.dup, 1) == [1]
  puts run_program(program.dup, 100) == [1]
  # output 0 if input 0, 1 if input non-zero
  program = '3,3,1105,-1,9,1101,0,0,12,4,12,99,1'.split(',').map(&:to_i)
  puts run_program(program.dup, 0) == [0]
  puts run_program(program.dup, -1) == [1]
  puts run_program(program.dup, 1) == [1]
  puts run_program(program.dup, 100) == [1]

  # large example
  # if input < 8, output 999
  # if input == 8, output 1000
  # if input > 8, output 1001
  puts 'large example'
  program = '3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99'.split(',').map(&:to_i)
  puts run_program(program.dup, 0) == [999]
  puts run_program(program.dup, -1) == [999]
  puts run_program(program.dup, 7) == [999]
  puts run_program(program.dup, -8) == [999]
  puts run_program(program.dup, 8) == [1000]
  puts run_program(program.dup, 9) == [1001]
  puts run_program(program.dup, 18) == [1001]
  puts run_program(program.dup, 100) == [1001]
end

test

lines = File.readlines('./input.txt')
first_line = lines.first
positions = first_line.split(',').map(&:to_i)
# Part 1
outputs = run_program(positions.dup, 1)
# [0, 0, 0, 0, 0, 0, 0, 0, 0, 15097178]
puts "#{outputs}"

# Part 2
outputs = run_program(positions.dup, 5)
puts "#{outputs}"
