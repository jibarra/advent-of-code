def read_file(file_name="day11_input.txt"):
    data = ""
    with open(file_name, "r") as file:
        data = file.read()
    return data


def parseInput(file_name="day11_input.txt"):
    return read_file(file_name).split(",")


# returns tuple (north, east, south, west) of movement changes
def process_movement(movement, north, east, south, west):
    if "n" in movement:
        north += 1
    elif "s" in movement:
        south += 1
    if "e" in movement:
        east += 1
    elif "w" in movement:
        west += 1
    return north, east, south, west
    # if movement == "n":
    #     return north + 1, east, south, west
    # elif movement == "ne":
    #     return north + 1, east + 1, south, west
    # elif movement == "e":
    #     return north, east + 1, south, west
    # elif movement == "se":
    #     return north, east + 1, south + 1, west
    # elif movement == "s":
    #     return north, east, south + 1, west
    # elif movement == "sw":
    #     return north, east, south + 1, west + 1
    # elif movement == "w":
    #     return north, east, south, west + 1
    # elif movement == "nw":
    #     return north + 1, east, south, west + 1


def part1():
    movements = parseInput("test_input.txt")
    north = 0
    east = 0
    south = 0
    west = 0

    for movement in movements:
        north, east, south, west = process_movement(movement, north, east, south, west)



    print(str(north) + " " + str(east) + " " + str(south) + " " + str(west))
    # move_horizontal = abs(move_horizontal)
    # move_vertical = abs(move_vertical)
    print(str(north) + " " + str(east) + " " + str(south) + " " + str(west))
    spaces = 0

    horizontal_max = max(east, west)
    horizontal_min = min(east, west)
    vertical_max = max(north, south)
    vertical_min = min(north, south)
    top_min = max(horizontal_min, vertical_min)


    #
    horizontal = horizontal_max - horizontal_min - vertical_min
    vertical = vertical_max - vertical_min - horizontal_min

    print(str(horizontal))
    print(str(vertical))


    while horizontal > 0 and vertical > 0:
        spaces += 1
        horizontal -= 1
        vertical -= 1

    if horizontal > 0:
        while horizontal > 0:
            spaces += 1
            horizontal -= 1

    if vertical > 0:
        while vertical > 0:
            spaces += 1
            vertical -= 1

    print("part1 answer: " + str(spaces))


part1()
