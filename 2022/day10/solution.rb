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

LIT = '#'
DARK = '.'

def draw_screen(sprite_position, crt_position)
  if (sprite_position-1..sprite_position+1).include?(crt_position)
    LIT
  else
    DARK
  end
end

def add_row_to_screen(crt_screen)
  current_row = crt_screen.last
  if !current_row || current_row.none? { |c| c.nil? }
    row = (1..40).map { |_| nil }
    crt_screen.push(row)
  end
end

screen = []
add_row_to_screen(screen)

current_sprite_position = 1
current_crt_position = 0

lines.each do |line|
  instruction, potential_number = line.split(' ')

  if instruction == NOOP
    # one cycle
    add_row_to_screen(screen)
    screen.last[current_crt_position] = draw_screen(current_sprite_position, current_crt_position)
    current_crt_position = (current_crt_position + 1) % 40
  elsif instruction == ADD
    # first cycle
    add_row_to_screen(screen)
    screen.last[current_crt_position] = draw_screen(current_sprite_position, current_crt_position)
    current_crt_position = (current_crt_position + 1) % 40

    # second cycle
    add_row_to_screen(screen)
    screen.last[current_crt_position] = draw_screen(current_sprite_position, current_crt_position)
    current_crt_position = (current_crt_position + 1) % 40

    current_sprite_position += potential_number.to_i
  else
    raise ArgumentError, "invalid instruction: #{instruction}"
  end
end

screen.each do |screen_line|
  string_line = ''
  screen_line.each do |c|
    string_line += c
  end
  puts string_line
end
