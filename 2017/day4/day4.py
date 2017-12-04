def read_file(file_name):
    data = ""
    with open(file_name, "r") as file:
        data = file.read()
    return data


def parse_input(text):
    lines = text.split("\n")
    return lines


def part1():
    lines = parse_input(read_file("day4_input.txt"))
    good_passphrases = 0
    for line in lines:
        words = line.split(" ")
        mapped_words = set()
        is_good_passphrase = True
        for word in words:
            if word in mapped_words:
                is_good_passphrase = False
            else:
                mapped_words.add(word)
        if is_good_passphrase is True:
            good_passphrases += 1
    print(good_passphrases)


def part2():
    lines = parse_input(read_file("day4_input.txt"))
    good_passphrases = 0
    for line in lines:
        words = line.split(" ")
        mapped_words = set()
        is_good_passphrase = True
        for word in words:
            sorted_word = ''.join(sorted(word))
            if sorted_word in mapped_words:
                is_good_passphrase = False
            else:
                mapped_words.add(sorted_word)
        if is_good_passphrase is True:
            good_passphrases += 1
    print(good_passphrases)


part1()
part2()
