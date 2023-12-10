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

def part_2(parsed_lines)
    card_matches = card_matches(parsed_lines)
    scratchcards_to_count = parsed_lines.each_with_object({}) { |line, memo| memo[line[:card_number]] = 1 }

    parsed_lines.each do |parsed_line|
        card_number = parsed_line[:card_number]
        number_of_cards_won = card_matches[card_number]
        quantity_of_future_cards_to_add = scratchcards_to_count[card_number]

        (0..(number_of_cards_won - 1)).each_with_index do |_, index|
            won_card_number = card_number + index + 1
            scratchcards_to_count[won_card_number] += quantity_of_future_cards_to_add
        end
    end

    scratchcards_to_count.values.sum
end

parsed_lines = input_lines.map { |line| parse(line) }

puts part_1(parsed_lines)
puts part_2(parsed_lines)