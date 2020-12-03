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

tree_count_right_1_down_1 = trees_encountered(tree_coordinates, 1, 1)
tree_count_right_3_down_1 = trees_encountered(tree_coordinates, 3, 1)
tree_count_right_5_down_1 = trees_encountered(tree_coordinates, 5, 1)
tree_count_right_7_down_1 = trees_encountered(tree_coordinates, 7, 1)
tree_count_right_1_down_2 = trees_encountered(tree_coordinates, 1, 2)


puts (
  tree_count_right_1_down_1 *
  tree_count_right_3_down_1 *
  tree_count_right_5_down_1 *
  tree_count_right_7_down_1 *
  tree_count_right_1_down_2
)
