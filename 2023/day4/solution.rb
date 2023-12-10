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

def card_matches(parsed_lines)
    card_matches = {}
    parsed_lines.each do |parsed_line|
        matched_numbers = parsed_line[:numbers_you_have].select do |number|
            parsed_line[:winning_numbers].include?(number)
        end
        card_matches[parsed_line[:card_number]] = matched_numbers.size
    end
    card_matches
end

def part_1(parsed_lines)
    part_1_total = 0
    card_matches(parsed_lines).each do |card_number, matches|
        total = 0
        (1..matches).each { |_| total = total == 0 ? 1 : total * 2 }
        part_1_total += total
    end

    part_1_total
end

parsed_lines = input_lines.map { |line| parse(line) }

puts part_1(parsed_lines)