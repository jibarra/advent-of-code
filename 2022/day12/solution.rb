require 'set'

lines = File.readlines('./input.txt').map(&:strip)

def find_start(lines)
  lines.each_with_index do |line, y_index|
    line.chars.each_with_index do |element, x_index|
      if element == 'S'
        return [x_index, y_index]
      end
    end
  end
end

def get_height_value(cell_value)
  case cell_value
  when 'S'
    'a'.ord
  when 'E'
    'z'.ord
  else
    cell_value.ord
  end
end

def get_height_range(cell_value)
  height = get_height_value(cell_value)
  (0..height+1)
end

def visit_graph(lines, x_index, y_index, visited_spaces, route, completed_routes)
  current_route = route.dup.push("#{x_index}.#{y_index}")

  if visited_spaces["#{x_index}.#{y_index}"] && visited_spaces["#{x_index}.#{y_index}"] <= current_route.size
    return
  end

  visited_spaces["#{x_index}.#{y_index}"] = current_route.size

  cell_value = lines[y_index][x_index]

  if cell_value == 'E'
    completed_routes[current_route] = current_route.size
    return
  end

  height = get_height_value(cell_value)

  if x_index > 0
    left_height = get_height_value(lines[y_index][x_index])
    if left_height <= height + 1
      visit_graph(lines, x_index - 1, y_index, visited_spaces, current_route, completed_routes)
    end
  end

  if y_index > 0
    down_height = get_height_value(lines[y_index - 1][x_index])
    if down_height <= height + 1
      visit_graph(lines, x_index, y_index - 1, visited_spaces, current_route, completed_routes)
    end
  end

  if x_index < lines.first.size + 1
    right_height = get_height_value(lines[y_index][x_index + 1])
    if right_height <= height + 1
      visit_graph(lines, x_index + 1, y_index, visited_spaces, current_route, completed_routes)
    end
  end

  if y_index < lines.size - 1
    up_height = get_height_value(lines[y_index + 1][x_index])
    if up_height <= height + 1
      visit_graph(lines, x_index, y_index + 1, visited_spaces, current_route, completed_routes)
    end
  end
end

visited_spaces = {}
route = []
completed_routes = {}

starting_x_index, starting_y_index = find_start(lines)
visit_graph(lines, starting_x_index, starting_y_index, visited_spaces, route, completed_routes)
pp completed_routes
