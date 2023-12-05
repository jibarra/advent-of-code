lines = File.readlines('./input.txt')

sum = 0
lines.each do |line|
    matches = line.scan(/\d{1}/)

    sum += "#{matches[0]}#{matches[-1]}".to_i
end

# Part 1
puts sum

sum = 0
lines.each do |line|
    numeric_strings = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
    numeric_strings.each_with_index do |numeric_string, index|
        line.gsub!(numeric_string, "#{numeric_string[0..1]}#{index + 1}#{numeric_string[2..-1]}")
    end

    matches = line.scan(/\d{1}/)
    sum += "#{matches[0]}#{matches[-1]}".to_i
end

# Part 2
puts sum