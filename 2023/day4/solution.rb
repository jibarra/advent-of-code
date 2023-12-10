input_lines = File.readlines('./input.txt').each(&:strip!)

def parse(line)
    matches = line.match(/Card +(\d+): +((\d| )+) \|((\d| )+)/)

    card_number = matches.captures[0].to_i
    winning_numbers = matches.captures[1].split(/ +/).map(&:to_i)
    numbers_you_have = matches.captures[3].split(/ +/).map(&:to_i)
    {
        card_number: card_number,
        winning_numbers: winning_numbers,
        numbers_you_have: numbers_you_have,
    }
end

def part_1(parsed_lines)
    total_points = []
    parsed_lines.each do |parsed_line|
        matched_numbers = parsed_line[:numbers_you_have].select do |number|
            parsed_line[:winning_numbers].include?(number)
        end
        total = 0
        matched_numbers.each { |_| total = total == 0 ? 1 : total * 2}
        total_points << total
    end
    total_points.sum
end

parsed_lines = input_lines.map { |line| parse(line) }
puts parsed_lines

puts part_1(parsed_lines)