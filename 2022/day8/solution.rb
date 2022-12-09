lines = File.readlines('./input.txt').map(&:strip)

tree_patch = lines.map do |row|
  tree_row = row.split('')
  tree_row.map(&:to_i)
end

def visible?(row_index, column_index, tree_patch)
  tree_height = tree_patch[row_index][column_index]

  # Row edge
  if row_index == 0 || row_index == tree_patch.size - 1
    return true
  # Column edge
  elsif column_index == 0 || column_index == tree_patch[row_index].size - 1
    return true
  else
    tree_row = tree_patch[row_index]
    left_tree_row = tree_row[0..column_index - 1]
    return true if left_tree_row.all? { |other_height| other_height < tree_height }

    right_tree_row = tree_row[column_index + 1..-1]
    return true if right_tree_row.all? { |other_height| other_height < tree_height }

    tree_column = tree_patch.map { |tree_row| tree_row[column_index] }
    up_tree_row = tree_column[0..row_index - 1]
    return true if up_tree_row.all? { |other_height| other_height < tree_height }

    down_tree_row = tree_column[row_index + 1..-1]
    return true if down_tree_row.all? { |other_height| other_height < tree_height }
  end

  return false
end

visible_count = 0
tree_patch.each_with_index do |tree_row, row_index|
  tree_row.each_with_index do |tree_height, column_index|
    if visible?(row_index, column_index, tree_patch)
      visible_count += 1
    end
  end
end

# Part 1
pp visible_count

# Part 2
def scenic_score(row_index, column_index, tree_patch)
  tree_height = tree_patch[row_index][column_index]

  # Row edge
  if row_index == 0 || row_index == tree_patch.size - 1
    return 0
  # Column edge
  elsif column_index == 0 || column_index == tree_patch[row_index].size - 1
    return 0
  end

  tree_row = tree_patch[row_index]

  left_score = 0
  left_tree_row = tree_row[0..column_index - 1].reverse
  left_tree_row.each do |other_height|
    left_score += 1
    if tree_height <= other_height
      break
    end
  end

  right_score = 0
  right_tree_row = tree_row[column_index + 1..-1]
  right_tree_row.each do |other_height|
    right_score += 1
    if tree_height <= other_height
      break
    end
  end

  tree_column = tree_patch.map { |tree_row| tree_row[column_index] }
  up_score = 0
  up_tree_row = tree_column[0..row_index - 1].reverse
  up_tree_row.each do |other_height|
    up_score += 1
    if tree_height <= other_height
      break
    end
  end

  down_score = 0
  down_tree_row = tree_column[row_index + 1..-1]
  down_tree_row.each do |other_height|
    down_score += 1
    if tree_height <= other_height
      break
    end
  end

  left_score * right_score * up_score * down_score
end

max_scenic_score = 0

tree_patch.each_with_index do |tree_row, row_index|
  tree_row.each_with_index do |tree_height, column_index|
    current_score = scenic_score(row_index, column_index, tree_patch)
    if current_score > max_scenic_score
      max_scenic_score = current_score
    end
  end
end

pp max_scenic_score
