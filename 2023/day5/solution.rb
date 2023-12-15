require 'set'

MAP_NAMES = [
    'seed-to-soil',
    'soil-to-fertilizer',
    'fertilizer-to-water',
    'water-to-light',
    'light-to-temperature',
    'temperature-to-humidity',
    'humidity-to-location',
]

def get_seeds_if_individual(input_lines)
    target_line = input_lines.find { |line| line.include?('seeds:')}
    seed_numbers = target_line.scan(/\d+/)
    seed_numbers.map(&:to_i)
end

def get_seed_ranges(input_lines)
    target_line = input_lines.find { |line| line.include?('seeds:')}
    seed_numbers = target_line.scan(/\d+/).map(&:to_i)
    seed_numbers.each_slice(2).map do |seed_start, seed_range|
        (seed_start...seed_start + seed_range)
    end
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

    sources_to_destination_ranges = []
    target_lines.each do |line|
        destination_start, source_start, range_length = line.split(' ').map(&:to_i)
        sources_to_destination_ranges << [
            (source_start...source_start + range_length), 
            (destination_start...destination_start + range_length),
        ]
    end

    sources_to_destination_ranges
end

def convert(sources, sources_to_destination_ranges)
    sources.map do |source|
        destination = nil
        sources_to_destination_ranges.each do |source_range, destination_range|
            if source_range.include?(source)
                distance_into_range = source - source_range.begin
                destination = destination_range.begin + distance_into_range
            end
        end

        destination || source
    end
end

def convert_seeds_to_location(seeds, input_lines)
    eventual_locations = seeds

    MAP_NAMES.each do |map_name|
        sources_to_destinations = build_map(map_name, input_lines)
        eventual_locations = convert(eventual_locations, sources_to_destinations)
    end

    eventual_locations
end

def part_1(input_lines)
    seeds = get_seeds_if_individual(input_lines)
    locations = convert_seeds_to_location(seeds, input_lines)
    locations.min
end

def part_2(input_lines)
    location = 0
    seed_ranges = get_seed_ranges(input_lines)
    lowest_found = false

    maps = MAP_NAMES.reverse.map do |map_name|
        build_map(map_name, input_lines).map { |source, destination| [destination, source] }
    end

    while !lowest_found
        eventual_seed = [location]
        pp eventual_seed
        maps.each do |map|
            eventual_seed = convert(eventual_seed, map)
        end
        if seed_ranges.any? { |seed_range| seed_range.include?(eventual_seed.first)}
            lowest_found = true
        else
            location += 1
        end
    end

    location
end

input_lines = File.readlines('./input.txt').each(&:strip!)
pp part_1(input_lines)
pp part_2(input_lines)
