def read_file(file_name):
    data = ""
    with open(file_name, "r") as file:
        data = file.read()
    return data


def part1():
    instructions = [int(x) for x in read_file("day5_input.txt").split("\n")]
    print(instructions)
    steps = 0
    i = 0
    while i < len(instructions) or i < 0:
        steps += 1
        jump = instructions[i]
        instructions[i] += 1
        i += jump
    print(steps)


def part2():
    instructions = [int(x) for x in read_file("day5_input.txt").split("\n")]
    print(instructions)
    steps = 0
    i = 0
    while i < len(instructions) or i < 0:
        steps += 1
        jump = instructions[i]
        if jump >= 3:
            instructions[i] -= 1
        else:
            instructions[i] += 1
        i += jump
    print(steps)


part1()
part2()
