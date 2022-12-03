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

# Part 2
LOSE_INPUT = 'X'
DRAW_INPUT = 'Y'
WIN_INPUT = 'Z'

def result_to_self_choice(opponent_choice, desired_result)
  if opponent_choice == OPPONENT_ROCK
    case desired_result
    when LOSE_INPUT
      return SELF_SCISSORS
    when DRAW_INPUT
      return SELF_ROCK
    when WIN_INPUT
      return SELF_PAPER
    end
  elsif opponent_choice == OPPONENT_PAPER
    case desired_result
    when LOSE_INPUT
      return SELF_ROCK
    when DRAW_INPUT
      return SELF_PAPER
    when WIN_INPUT
      return SELF_SCISSORS
    end
  elsif opponent_choice == OPPONENT_SCISSORS
    case desired_result
    when LOSE_INPUT
      return SELF_PAPER
    when DRAW_INPUT
      return SELF_SCISSORS
    when WIN_INPUT
      return SELF_ROCK
    end
  else
    puts 'bad input'
  end
end

total_score = 0
lines.each do |round|
  choices = round.split(' ')
  opponent_choice = choices[0]
  desired_result = choices[1]

  round_score = 0
  case desired_result
  when LOSE_INPUT
    round_score = LOSE_SCORE
  when DRAW_INPUT
    round_score = DRAW_SCORE
  when WIN_INPUT
    round_score = WIN_SCORE
  end

  self_choice = result_to_self_choice(opponent_choice, desired_result)

  case self_choice
  when SELF_ROCK
    round_score += CHOOSE_ROCK_SCORE
  when SELF_PAPER
    round_score += CHOOSE_PAPER_SCORE
  when SELF_SCISSORS
    round_score += CHOOSE_SCISSORS_SCORE
  end
  
  total_score += round_score
end

puts total_score
