lines = File.readlines('./input.txt')

tree_coordinates = []
lines.each do |line|
  tree_coordinates << line.gsub("\n", '').split('')
end

bottom_of_mountain = tree_coordinates.size
current_y = 0
current_x = 0
tree_count = 0

while(current_y < bottom_of_mountain)
  if tree_coordinates[current_y][current_x] == '#'
    tree_count = tree_count + 1
  end

  current_x = (current_x + 3) % tree_coordinates[current_y].size
  current_y = current_y + 1
end

puts tree_count