lines = File.readlines('./input.txt')

tree_coordinates = []
lines.each do |line|
  tree_coordinates << line.gsub("\n", '').split('')
end

def trees_encountered(tree_coordinates, add_x, add_y)
  bottom_of_mountain = tree_coordinates.size
  current_y = 0
  current_x = 0
  tree_count = 0

  while(current_y < bottom_of_mountain)
    if tree_coordinates[current_y][current_x] == '#'
      tree_count = tree_count + 1
    end

    current_x = (current_x + add_x) % tree_coordinates[current_y].size
    current_y = current_y + add_y
  end

  tree_count
end

tree_count = trees_encountered(tree_coordinates, 3, 1)
puts tree_count
