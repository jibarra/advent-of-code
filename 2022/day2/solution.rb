lines = File.readlines('./input.txt')

# Part 1
OPPONENT_ROCK = 'A'
OPPONENT_PAPER = 'B'
OPPONENT_SCISSORS = 'C'

SELF_ROCK = 'X'
SELF_PAPER = 'Y'
SELF_SCISSORS = 'Z'

CHOOSE_ROCK_SCORE = 1
CHOOSE_PAPER_SCORE = 2
CHOOSE_SCISSORS_SCORE = 3

LOSE_SCORE = 0
DRAW_SCORE = 3
WIN_SCORE = 6

def round_result(opponent_choice, self_choice)
  if opponent_choice == OPPONENT_ROCK
    case self_choice
    when SELF_ROCK
      return :draw
    when SELF_PAPER
      return :win
    when SELF_SCISSORS
      return :lose
    end
  elsif opponent_choice == OPPONENT_PAPER
    case self_choice
    when SELF_ROCK
      return :lose
    when SELF_PAPER
      return :draw
    when SELF_SCISSORS
      return :win
    end
  elsif opponent_choice == OPPONENT_SCISSORS
    case self_choice
    when SELF_ROCK
      return :win
    when SELF_PAPER
      return :lose
    when SELF_SCISSORS
      return :draw
    end
  else
    puts 'bad input'
  end
end

total_score = 0

lines.each do |round|
  choices = round.split(' ')
  opponent_choice = choices[0]
  self_choice = choices[1]

  round_score = 0
  case self_choice
  when SELF_ROCK
    round_score = CHOOSE_ROCK_SCORE
  when SELF_PAPER
    round_score = CHOOSE_PAPER_SCORE
  when SELF_SCISSORS
    round_score = CHOOSE_SCISSORS_SCORE
  end

  result = round_result(opponent_choice, self_choice)

  case result
  when :win
    round_score += WIN_SCORE
  when :draw
    round_score += DRAW_SCORE
  when :lose
    round_score += LOSE_SCORE
  end
  
  total_score += round_score
end

puts total_score
