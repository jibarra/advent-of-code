def read_file(file_name):
    data = ""
    with open(file_name, "r") as file:
        data = file.read()
    return data


def banks_string_representation(banks):
    return ' '.join(str(x) for x in banks)


def is_infinite_loop(banks, previous_allocations):
    return banks_string_representation(banks) in previous_allocations


def reallocate_banks(banks):
    max_index = banks.index(max(banks))
    size = len(banks)
    blocks = banks[max_index]
    banks[max_index] = 0
    i = (max_index + 1) % size

    for redistribute_blocks in range(blocks, 0, -1):
        banks[i] += 1
        i = (i + 1) % size


def part1():
    banks = [int(x) for x in read_file("day6_input.txt").split("\t")]
    previous_allocations = set()
    reallocations = 0
    while not is_infinite_loop(banks, previous_allocations):
        previous_allocations.add(banks_string_representation(banks))
        reallocate_banks(banks)
        reallocations += 1
    print(reallocations)


def part2():
    banks = [int(x) for x in read_file("day6_input.txt").split("\t")]
    previous_allocations = set()
    previous_allocations_cycle = dict()
    reallocations = 0
    while not is_infinite_loop(banks, previous_allocations):
        previous_allocations.add(banks_string_representation(banks))
        reallocate_banks(banks)
        reallocations += 1
        if not banks_string_representation(banks) in previous_allocations_cycle:
            previous_allocations_cycle[banks_string_representation(banks)] = reallocations
    print(previous_allocations_cycle[banks_string_representation(banks)])
    print(reallocations - previous_allocations_cycle[banks_string_representation(banks)])
    print(reallocations)


part1()
part2()
