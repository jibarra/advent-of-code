# TODO: not the best method name
def digits_never_decrease(number)
  i = 0
  digits = number.digits.reverse
  digits.all? do |digit|
    i += 1
    if i >= digits.size
      true
    else
      digit <= digits[i]
    end
  end
end

def has_adjacent_same_digit(number)
  i = 0
  digits = number.digits
  digits.any? do |digit|
    i += 1
    if i >= digits.size
      false
    else
      digit == digits[i]
    end
  end
end

def has_repeating_digits_of_just_2_count(number)
  digits = number.digits

  i = 1

  previous_digit = digits.first
  run_count = 0
  while(i < digits.size)
    if previous_digit == digits[i]
      run_count += 1
    else
      return true if run_count == 1

      run_count = 0
    end
    previous_digit = digits[i]
    i += 1
  end
  
  if run_count == 1
    true
  else
    false
  end
end

def has_no_repeating_group_odd_count(number)
  digits = number.digits
  repeated_digit_group_counts = []
  current_repeated_digit = nil
  current_repeated_digit_count = 2
  digits.each_with_index do |digit, i|
    next if (i + 1) >= digits.size

    if digit == digits[i + 1]
      if current_repeated_digit == digit
        current_repeated_digit_count += 1
      else
        repeated_digit_group_counts << current_repeated_digit_count
        current_repeated_digit = digit
        current_repeated_digit_count = 2
      end
    end
  end

  if current_repeated_digit
    repeated_digit_group_counts << current_repeated_digit_count
  end

  repeated_digit_group_counts.all? { |num| num.even? }
end

def test_methods
  puts 'test digits_never_decrease'
  puts digits_never_decrease(123456) == true
  puts digits_never_decrease(111111) == true
  puts digits_never_decrease(123454) == false
  puts digits_never_decrease(132) == false

  puts 'test has_adjacent_same_digit'
  puts has_adjacent_same_digit(123456) == false
  puts has_adjacent_same_digit(111111) == true
  puts has_adjacent_same_digit(112345) == true
  puts has_adjacent_same_digit(123445) == true
  puts has_adjacent_same_digit(123455) == true

  puts 'has_repeating_digits_of_just_2_count'
  puts has_repeating_digits_of_just_2_count(123456) == false
  puts has_repeating_digits_of_just_2_count(112233) == true
  puts has_repeating_digits_of_just_2_count(123444) == false
  puts has_repeating_digits_of_just_2_count(111111) == false
  puts has_repeating_digits_of_just_2_count(111122) == true
  puts has_repeating_digits_of_just_2_count(123455) == true
  puts has_repeating_digits_of_just_2_count(123555) == false
  puts has_repeating_digits_of_just_2_count(1135555) == true
  puts has_repeating_digits_of_just_2_count(5555311) == true
end

test_methods

input_range = (307237..769058)

# Part 1
possible_passwords = input_range.select do |number|
  digits_never_decrease(number) && has_adjacent_same_digit(number)
end

puts possible_passwords.size

possible_passwords = input_range.select do |number|
  digits_never_decrease(number) && has_repeating_digits_of_just_2_count(number)
end

# 349 is too low, 491 is too low
puts possible_passwords.size