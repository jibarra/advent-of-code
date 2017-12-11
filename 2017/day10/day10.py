standard_ascii_input_lengths = [17, 31, 73, 47, 23]

def read_file(file_name="day10_input.txt"):
    data = ""
    with open(file_name, "r") as file:
        data = file.read()
    return data


def get_input_lengths():
    return [int(x) for x in read_file().split(",")]


def get_ascii_input_lengths():
    data = read_file().rstrip()

    input_lengths = [ord(x) for x in data]

    for standard_length in standard_ascii_input_lengths:
        input_lengths.append(standard_length)

    return input_lengths


def generate_number_list(list_size):
    number_list = []
    for i in range(0, list_size):
        number_list.append(i)
    return number_list


def process_knot_hash(number_list, list_size, input_lengths, current_position, skip_size):
    for length_value in input_lengths:
        reverse_list = []
        for i in range(0, length_value):
            reverse_list.append(number_list[(current_position + i) % list_size])
        reverse_list = reverse_list[::-1]
        for i in range(0, length_value):
            number_list[(current_position + i) % list_size] = reverse_list[i]
        current_position = (current_position + length_value + skip_size) % list_size
        skip_size += 1

    return current_position, skip_size


def produce_dense_hash(number_list):
    dense_hash = []
    for i in range(0, int(len(number_list) / 16)):
        hash_value = number_list[0 + (i * 16)]
        for j in range(1, 16):
            hash_value = hash_value ^ number_list[j + (i * 16)]
        dense_hash.append(hash_value)
    return dense_hash


def generate_hex_values(number_list):
    hex_values = []
    for num in number_list:
        hex_value = hex(num)
        hex_value = hex_value[2:]
        if len(hex_value) < 2:
            hex_value = "0" + hex_value
        hex_values.append(hex_value)
    return hex_values


def part1():
    print("part1")
    list_size = 256
    number_list = generate_number_list(list_size)
    input_lengths = get_input_lengths()
    process_knot_hash(number_list, list_size, input_lengths, 0, 0)
    print(number_list)
    print(number_list[0] * number_list[1])


def part2():
    print("part2")
    list_size = 256
    number_list = generate_number_list(list_size)
    input_lengths = get_ascii_input_lengths()

    current_position = 0
    skip_size = 0
    for i in range(0, 64):
        current_position, skip_size = process_knot_hash(number_list, list_size, input_lengths, current_position, skip_size)
    dense_hash = produce_dense_hash(number_list)
    hex_values = generate_hex_values(dense_hash)
    print(hex_values)
    hex_value = ""
    for val in hex_values:
        hex_value += val
    print(hex_value)


part1()
part2()
# dense = produce_dense_hash([38,171,116,63,70,137,168,29,198,55,160,15,34,95,58,7,188,189,238,141,30,31,124,241,20,1,244,203,234,73,236,211,122,197,94,227,142,57,72,239,54,81,154,217,10,13,186,161,6,17,128,105,106,69,44,51,248,23,136,173,52,39,40,5,254,195,64,187,192,37,230,153,56,177,84,147,96,249,252,121,166,143,62,169,90,99,196,155,132,159,162,229,76,117,164,127,150,21,88,27,242,67,114,115,226,191,190,53,2,65,206,205,24,251,14,75,74,247,80,11,50,181,46,101,100,179,48,131,32,97,102,201,170,93,104,103,182,125,12,43,220,113,158,167,68,47,66,33,112,135,194,185,218,219,8,245,130,253,204,243,202,109,92,209,156,133,250,107,4,183,60,215,172,231,240,83,98,193,82,139,210,91,146,85,184,163,140,145,178,35,232,151,214,213,200,199,18,221,212,9,152,123,78,3,228,25,26,225,0,61,138,255,222,233,110,129,208,207,176,235,108,77,148,19,180,79,28,149,224,237,86,157,216,111,22,89,16,41,144,71,134,59,246,165,174,223,118,119,36,175,126,87,120,45,42,49])
# print(generate_hex_values(dense))
