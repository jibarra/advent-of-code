input_lines = File.readlines('./input.txt')
MAX_RED = 12
MAX_GREEN = 13
MAX_BLUE = 14

class Pull
    attr_accessor :red, :green, :blue

    def initialize(red, green, blue)
        @red = red
        @green = green
        @blue = blue
    end

    def to_s
        "Pull { red: #{@red}, green: #{@green}, blue: #{@blue}}"
    end
end

def parse_pulls(game_pulls)
    game_pulls.split(';').map do |individual_pull|
        red = individual_pull.match(/(\d+) red/)&.captures&.[](0)&.to_i || 0
        green = individual_pull.match(/(\d+) green/)&.captures&.[](0)&.to_i || 0
        blue = individual_pull.match(/(\d+) blue/)&.captures&.[](0)&.to_i || 0

        Pull.new(red, green, blue)
    end
end

def parse_game(line)
    game_label, game_pulls = line.split(':')
    game_number = game_label.match(/\d+/)[0].to_i
    pulls = parse_pulls(game_pulls)
    [game_number, pulls]
end

def part_1(lines)
    possible_games = []

    lines.each do |line|
        game_number, pulls = parse_game(line)
    
        if pulls.all? { |pull| pull.red <= MAX_RED && pull.green <= MAX_GREEN && pull.blue <= MAX_BLUE }
            possible_games << game_number
        end
    end

    puts possible_games.sum
end

def part_2(lines)
    powers = []
    lines.each do |line|
        game_number, pulls = parse_game(line)

        min_red, min_green, min_blue = 0, 0, 0

        pulls.each do |pull|
            min_red = pull.red if pull.red > min_red
            min_green = pull.green if pull.green > min_green
            min_blue = pull.blue if pull.blue > min_blue
        end
        powers << min_red * min_green * min_blue
    end

    puts powers.sum
end

part_1(input_lines)
part_2(input_lines)