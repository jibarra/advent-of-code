def read_file(file_name):
    data = ""
    with open(file_name, "r") as file:
        data = file.read()
    return data


def process_next_element_captcha(captcha_data):
    total = 0
    for i in range(0, (len(captcha_data) - 1)):
        if captcha_data[i] == captcha_data[i + 1]:
            total += captcha_data[i]

    if len(captcha_data) >= 2:
        if captcha_data[0] == captcha_data[len(captcha_data) - 1]:
            total += captcha_data[0]

    return total


def process_half_list_captcha(captcha_data):
    total = 0
    length = len(captcha_data)
    half_length = length / 2
    for i in range(0, length):
        if captcha_data[i] == captcha_data[int((i + half_length) % length)]:
            total += captcha_data[i]

    return total


def part1():
    data = read_file("day1_input.txt")
    captcha = [int(c) for c in data]
    print(process_next_element_captcha(captcha))


def part2():
    data = read_file("day1_input.txt")
    captcha = [int(c) for c in data]
    print(process_half_list_captcha(captcha))


part1()
part2()
