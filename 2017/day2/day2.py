def read_file(file_name):
    data = ""
    with open(file_name, "r") as file:
        data = file.read()
    return data


def parse_input(text):
    lines = text.split("\n")
    split_lines = []
    for line in lines:
        split_lines.append([int(x) for x in line.split("\t")])
    return split_lines


def find_divisible_numbers(numbers):
    for i in range(0, len(numbers)):
        for j in range(i + 1, len(numbers)):
            if numbers[i] % numbers[j] == 0 or numbers[j] % numbers[i] == 0:
                return numbers[i], numbers[j]


def part1():
    data = read_file("day2_input.txt")
    spreadsheet = parse_input(data)
    checksum = 0
    for row in spreadsheet:
        max_val = max(row)
        min_val = min(row)
        checksum += max_val - min_val
    print(checksum)


def part2():
    data = read_file("day2_input.txt")
    spreadsheet = parse_input(data)
    checksum = 0
    for row in spreadsheet:
        divisible_numbers = find_divisible_numbers(row)
        if divisible_numbers[0] > divisible_numbers[1]:
            checksum += divisible_numbers[0] / divisible_numbers[1]
        else:
            checksum += divisible_numbers[1] / divisible_numbers[0]
    print(checksum)


part1()
part2()
