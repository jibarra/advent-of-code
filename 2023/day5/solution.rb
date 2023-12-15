def get_seeds(input_lines)
    target_line = input_lines.find { |line| line.include?('seeds:')}
    seed_numbers = target_line.scan(/\d+/)
    seed_numbers.map(&:to_i)
end

def build_map(map_name, input_lines)
    map_header_found = false

    target_lines = input_lines.select do |line|
        if line.include?(map_name)
            map_header_found = true
            false
        elsif line.strip.empty?
            map_header_found = false
            false
        elsif map_header_found == true
            true
        end
    end

    sources_to_destinations = {}
    target_lines.each do |line|
        destination_start, source_start, range_length = line.split(' ').map(&:to_i)
        (destination_start...destination_start + range_length).each_with_index do |destination, index|
            sources_to_destinations[source_start + index] = destination
        end
    end

    sources_to_destinations
end

def convert(sources, sources_to_destinations)
    sources.map do |source|
        sources_to_destinations[source] || source
    end
end

def part_1(input_lines)
    sources_to_convert = get_seeds(input_lines)

    seed_to_soil = build_map('seed-to-soil', input_lines)
    sources_to_convert = convert(sources_to_convert, seed_to_soil)

    soil_to_fertilizer = build_map('soil-to-fertilizer', input_lines)
    sources_to_convert = convert(sources_to_convert, soil_to_fertilizer)

    fertilizer_to_water = build_map('fertilizer-to-water', input_lines)
    sources_to_convert = convert(sources_to_convert, fertilizer_to_water)

    water_to_light = build_map('water-to-light', input_lines)
    sources_to_convert = convert(sources_to_convert, water_to_light)

    light_to_temperature = build_map('light-to-temperature', input_lines)
    sources_to_convert = convert(sources_to_convert, light_to_temperature)

    temperature_to_humidity = build_map('temperature-to-humidity', input_lines)
    sources_to_convert = convert(sources_to_convert, temperature_to_humidity)

    humidity_to_location = build_map('humidity-to-location', input_lines)
    sources_to_convert = convert(sources_to_convert, humidity_to_location)

    sources_to_convert.min
end

input_lines = File.readlines('./input.txt').each(&:strip!)
pp part_1(input_lines)