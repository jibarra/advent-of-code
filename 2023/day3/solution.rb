input_lines = File.readlines('./input.txt').each(&:strip!)

def is_part_number?(row_index, column_index_begin, column_index_end, lines)
    min_column_index = column_index_begin > 0 ? column_index_begin - 1 : column_index_begin
    max_column_index = column_index_end < lines.first.size - 1 ? column_index_end + 1 : column_index_end

    symbol_regex = /(?!\.)\W/

    return true if row_index > 0 && lines[row_index - 1][min_column_index..max_column_index].match?(symbol_regex)
    return true if row_index < lines.size - 1 && lines[row_index + 1][min_column_index..max_column_index].match?(symbol_regex)
    return true if lines[row_index][min_column_index].match?(symbol_regex)
    return true if lines[row_index][max_column_index].match?(symbol_regex)

    false
end

def part_1(lines)
    part_numbers = []
    lines.each_with_index do |line, row_index|
        matched_digits = line.match(/\d+/)
        while matched_digits
            column_match_begin, column_match_end = matched_digits.offset(0)
            # The offset returns + 1 from the actual end
            column_match_end = column_match_end - 1
            if is_part_number?(row_index, column_match_begin, column_match_end, lines)
                digits = matched_digits[0].to_i
                part_numbers << digits
            end
            matched_digits = line.match(/\d+/, column_match_end + 1)
        end
    end

    puts part_numbers.sum
end

part_1(input_lines)