def read_file(file_name="day10_input.txt"):
    data = ""
    with open(file_name, "r") as file:
        data = file.read()
    return data


def get_input_lengths():
    return [int(x) for x in read_file().split(",")]


def generate_number_list(list_size):
    number_list = []
    for i in range(0, list_size):
        number_list.append(i)
    return number_list


def process_knot_hash(number_list, list_size, input_lengths):
    skip_size = 0
    current_position = 0
    for length_value in input_lengths:
        reverse_list = []
        for i in range(0, length_value):
            reverse_list.append(number_list[(current_position + i) % list_size])
        reverse_list = reverse_list[::-1]
        j = 0
        for i in range(0, length_value):
            number_list[(current_position + i) % list_size] = reverse_list[j]
            j += 1
        current_position = (current_position + length_value + skip_size) % list_size
        skip_size += 1


def part1():
    list_size = 256
    number_list = generate_number_list(list_size)
    input_lengths = get_input_lengths()
    process_knot_hash(number_list, list_size, input_lengths)
    print(number_list)
    print(number_list[0] * number_list[1])


part1()
