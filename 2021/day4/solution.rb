lines = File.readlines('./input.txt')

class BoardSquare
  attr_accessor :value
  attr_accessor :value_drawn

  def initialize(value, value_drawn)
    @value = value
    @value_drawn = value_drawn
  end
end

def create_board_from_lines(board_lines)
  board = board_lines.map do |board_line|
    board_line.chars.each_slice(3).map do |values|
      value_string = values.join('').strip
      next if value_string.nil? || value_string.empty?

      board_square = BoardSquare.new(Integer(value_string, 10), false)
    end.compact
  end

  board.select { |board_line| !board_line.empty?}
end

def mark_value_drawn(drawn_number, boards)
  boards.each do |board|
    board.each do |board_line|
      board_line.each do |board_square|
        if board_square.value == drawn_number
          board_square.value_drawn = true
        end
      end
    end
  end
end

def is_board_winner?(board)
  board.each do |board_line|
    return board if board_line.all? { |board_square| board_square.value_drawn }
  end

  # Assuming 5 squares, can refactor later
  (0..4).each do |column_index|
    return board if board[0][column_index].value_drawn &&
      board[1][column_index].value_drawn &&
      board[2][column_index].value_drawn &&
      board[3][column_index].value_drawn &&
      board[4][column_index].value_drawn
  end

  nil
end

def find_winning_board(boards)
  # Only need to check rows and columns
  boards.each do |board|
    return board if is_board_winner?(board)
  end

  nil
end

def all_values_not_drawn(board)
  values_not_drawn = []
  board.each do |board_line|
    board_line.each do |board_square|
      if !board_square.value_drawn
        values_not_drawn << board_square.value
      end
    end
  end

  values_not_drawn
end


# Part 1
def first_winner(drawn_numbers, boards)
  winning_board = nil
  last_number_drawn = nil
  drawn_numbers.each do |drawn_number|
    last_number_drawn = drawn_number
    mark_value_drawn(drawn_number, boards)
    winning_board = find_winning_board(boards)
    break if !winning_board.nil?
  end

  winning_values_not_drawn = all_values_not_drawn(winning_board)
  sum_of_values_not_drawn = winning_values_not_drawn.sum
  puts last_number_drawn * sum_of_values_not_drawn
end

board_size = 5
drawn_numbers = lines.shift(2).first.split(',').map(&:to_i)

boards_for_first_winner = lines.each_slice(board_size + 1).map do |board_lines|
  create_board_from_lines(board_lines)
end

first_winner(drawn_numbers, boards_for_first_winner)

def last_winner(drawn_numbers, boards)
  last_winning_board = nil
  last_number_drawn = nil
  drawn_numbers.each do |drawn_number|
    last_number_drawn = drawn_number
    mark_value_drawn(drawn_number, boards)
    winning_boards = boards.select { |board| is_board_winner?(board) }
    boards = boards - winning_boards

    if boards.size == 0
      # Assume there's only one winning board at the end
      last_winning_board = winning_boards.first
      break;
    end
  end

  winning_values_not_drawn = all_values_not_drawn(last_winning_board)
  sum_of_values_not_drawn = winning_values_not_drawn.sum
  puts last_number_drawn * sum_of_values_not_drawn
end

boards_for_last_winner = lines.each_slice(board_size + 1).map do |board_lines|
  create_board_from_lines(board_lines)
end

last_winner(drawn_numbers, boards_for_last_winner)
