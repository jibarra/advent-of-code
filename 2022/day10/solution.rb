lines = File.readlines('./input.txt').map(&:strip)

ADD = 'addx'
NOOP = 'noop'

x_register = 1

signal_strengths = []
current_cycle = 1

def interesting_signal_strength(cycle, register_value)
  modified_cycle = cycle - 20
  
  if cycle < 20 || modified_cycle % 40 != 0
    return nil
  end

  cycle * register_value
end

lines.each do |line|
  instruction, potential_number = line.split(' ')

  if instruction == NOOP
    signal_strengths.push(interesting_signal_strength(current_cycle, x_register))
    current_cycle += 1
  elsif instruction == ADD
    signal_strengths.push(interesting_signal_strength(current_cycle, x_register))
    current_cycle += 1
    signal_strengths.push(interesting_signal_strength(current_cycle, x_register))
    current_cycle += 1
    x_register += potential_number.to_i
  else
    raise ArgumentError, "invalid instruction: #{instruction}"
  end
end

puts signal_strengths.compact.sum