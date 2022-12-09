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

pp visible_count
