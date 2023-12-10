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

def gears(row_index, column_index, lines)
    min_column_index = column_index > 0 ? column_index - 1 : column_index
    max_column_index = column_index < lines.first.size - 1 ? column_index + 1 : column_index
    min_max_column_range = (min_column_index..max_column_index)

    gears = []
    if row_index > 0
        above_line = lines[row_index - 1]
        above_line_numbers = []
        above_line.scan(/\d+/) { above_line_numbers << Regexp.last_match }
        above_line_numbers.each do |match_data|
            offset_range = (match_data.begin(0)..(match_data.end(0) - 1))
            gears << match_data[0].to_i if min_max_column_range.any? { |col| offset_range.include?(col) }
        end
    end

    current_line = lines[row_index]
    if column_index > 0 && lines[row_index][column_index - 1].match?(/\d/)
        current_line_numbers = []
        current_line.scan(/\d+/) { current_line_numbers << Regexp.last_match }
        current_line_numbers.each do |match_data|
            offset_range = (match_data.begin(0)..(match_data.end(0) - 1))
            gears << match_data[0].to_i if offset_range.include?(column_index - 1)
        end
    end

    if column_index < lines[row_index].size - 1 && lines[row_index][column_index + 1].match?(/\d/)
        current_line_numbers = []
        current_line.scan(/\d+/) { current_line_numbers << Regexp.last_match }
        current_line_numbers.each do |match_data|
            offset_range = (match_data.begin(0)..(match_data.end(0) - 1))
            gears << match_data[0].to_i if offset_range.include?(column_index + 1)
        end
    end

    if row_index < lines.size - 1
        below_line = lines[row_index + 1]
        below_line_numbers = []
        below_line.scan(/\d+/) { below_line_numbers << Regexp.last_match }
        below_line_numbers.each do |match_data|
            offset_range = (match_data.begin(0)..(match_data.end(0) - 1))
            gears << match_data[0].to_i if min_max_column_range.any? { |col| offset_range.include?(col) }
        end
    end

    gears
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

def part_2(lines)
    gear_ratios = []

    lines.each_with_index    do |line, row_index|
        potential_gear = line.match(/\*/)
        while potential_gear
            _column_match_begin, column_match_end = potential_gear.offset(0)
            column_match, _column_match_end = potential_gear.offset(0)
            potential_gears = gears(row_index, column_match, lines)

            if potential_gears.size == 2
                gear_ratios << potential_gears[0] * potential_gears[1]
            end
            potential_gear = line.match(/\*/, column_match_end + 1)
        end
    end

    puts gear_ratios.sum
end

part_1(input_lines)
part_2(input_lines)