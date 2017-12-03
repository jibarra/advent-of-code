import math

# day3_input = 23
day3_input = 347991

"""
Each new 'square' is an odd number squared. So the first
is 1^2, the next is 3^2, then 5^2, etc.

In these scenarios, the max distance is at the diagonals. The
diagonals are a distance of 1 less than the number squared
for that particular square. The min distance is ceil(odd_square / 2).

The start for each rotation is the max distance - 1.
"""
def part1(target_space):
    odd_square = int(math.ceil(math.sqrt(target_space)))
    if odd_square % 2 is 0:
        odd_square += 1
    max_distance = odd_square - 1
    min_distance = math.ceil(odd_square / 2) - 1
    current_distance = max_distance
    current_pos = ((odd_square - 2) * (odd_square - 2)) + 1
    is_positive_direction = False
    while current_pos <= target_space:
        if is_positive_direction:
            current_distance += 1
            if current_distance == max_distance:
                is_positive_direction = False
        else:
            current_distance -= 1
            if current_distance == min_distance:
                is_positive_direction = True
        current_pos += 1
    print(current_distance)


"""
Differences between diagonals (5, 3):

right side:
beginning square: 16
in between: 17
diagonal: 18

diagonals:
18
20
22
24

With 16?
"""
def determine_diagonal(current_square, current_space, spaces, difference_square):
    previous_square = current_square - 2
    difference = difference_square
    beginning_space = previous_square * previous_square + 1
    top_right_space = beginning_space + previous_square
    top_left_space = top_right_space + previous_square + 1
    bottom_left_space = top_left_space + previous_square + 1
    bottom_right_space = bottom_left_space + previous_square + 1

    # First space of square
    if beginning_space == current_space:
        index = current_space - difference
        return spaces[index] + spaces[current_space - 2]
    # Second space of square
    elif beginning_space + 1 == current_space:
        index = current_space - difference - 1
        return spaces[index] + spaces[index + 1] + spaces[current_space - 2] + spaces[current_space - 3]
    # Space before top right corner of square
    elif top_right_space - 1 == current_space:
        index = current_space - difference - 1
        return spaces[index] + spaces[index - 1] + spaces[current_space - 2]
    # Top right corner of square
    elif top_right_space == current_space:
        index = current_space - difference - 2
        return spaces[index] + spaces[current_space - 2]
    # Space after top right corner of square
    elif top_right_space + 1 == current_space:
        index = current_space - difference - 3
        return spaces[index] + spaces[index + 1] + spaces[current_space - 2] + spaces[current_space - 3]
    # Space before top left corner of square
    elif top_left_space - 1 == current_space:
        index = current_space - difference - 3
        return spaces[index] + spaces[index - 1] + spaces[current_space - 2]
    # Top left corner of square
    elif top_left_space == current_space:
        index = current_space - difference - 4
        return spaces[index] + spaces[current_space - 2]
    # Space after top left corner of square
    elif top_left_space + 1 == current_space:
        index = current_space - difference - 5
        return spaces[index] + spaces[index + 1] + spaces[current_space - 2] + spaces[current_space - 3]
    # Space before bottom left corner of square
    elif bottom_left_space - 1 == current_space:
        index = current_space - difference - 5
        return spaces[index] + spaces[index - 1] + spaces[current_space - 2]
    # Bottom left corner of square
    elif bottom_left_space == current_space:
        index = current_space - difference - 6
        return spaces[index] + spaces[current_space - 2]
    # Space after bottom left corner of square
    elif bottom_left_space + 1 == current_space:
        index = current_space - difference - 7
        return spaces[index] + spaces[index + 1] + spaces[current_space - 2] + spaces[current_space - 3]
    # Bottom right corner of square
    elif bottom_right_space == current_space:
        index = current_space - difference - 8
        return spaces[index] + spaces[index + 1] + spaces[current_space - 2]
    # Right spaces of square
    elif top_right_space > current_space:
        index = current_space - difference - 1
        return spaces[index - 1] + spaces[index] + spaces[index + 1] + spaces[current_space - 2]
    # Top spaces of square
    elif top_left_space > current_space:
        index = current_space - difference - 3
        return spaces[index - 1] + spaces[index] + spaces[index + 1] + spaces[current_space - 2]
    # Left spaces of square
    elif bottom_left_space > current_space:
        index = current_space - difference - 5
        return spaces[index - 1] + spaces[index] + spaces[index + 1] + spaces[current_space - 2]
    # Bottom spaces of square
    elif bottom_right_space > current_space:
        index = current_space - difference - 7
        return spaces[index - 1] + spaces[index] + spaces[index + 1] + spaces[current_space - 2]

# difference changes by 8 each time
def test_part2(target_value):
    spaces = [1, 1, 2, 4, 5, 10, 11, 23, 25, 26, 54]
    current_square = 5
    current_space = 12
    difference_square = 9

    spaces.append(determine_diagonal(current_square, current_space, spaces, difference_square))
    current_space += 1
    print(spaces)
    spaces.append(determine_diagonal(current_square, current_space, spaces, difference_square))
    current_space += 1
    print(spaces)
    spaces.append(determine_diagonal(current_square, current_space, spaces, difference_square))
    current_space += 1
    print(spaces)
    spaces.append(determine_diagonal(current_square, current_space, spaces, difference_square))
    current_space += 1
    print(spaces)
    spaces.append(determine_diagonal(current_square, current_space, spaces, difference_square))
    current_space += 1
    print(spaces)
    spaces.append(determine_diagonal(current_square, current_space, spaces, difference_square))
    current_space += 1
    print(spaces)
    spaces.append(determine_diagonal(current_square, current_space, spaces, difference_square))
    current_space += 1
    print(spaces)
    spaces.append(determine_diagonal(current_square, current_space, spaces, difference_square))
    current_space += 1
    print(spaces)
    spaces.append(determine_diagonal(current_square, current_space, spaces, difference_square))
    current_space += 1
    print(spaces)
    spaces.append(determine_diagonal(current_square, current_space, spaces, difference_square))
    current_space += 1
    print(spaces)
    spaces.append(determine_diagonal(current_square, current_space, spaces, difference_square))
    current_space += 1
    print(spaces)
    spaces.append(determine_diagonal(current_square, current_space, spaces, difference_square))
    current_space += 1
    print(spaces)
    spaces.append(determine_diagonal(current_square, current_space, spaces, difference_square))
    current_space += 1
    print(spaces)
    spaces.append(determine_diagonal(current_square, current_space, spaces, difference_square))
    current_space += 1
    current_square += 2
    difference_square = 17
    print(spaces)
    spaces.append(determine_diagonal(current_square, current_space, spaces, difference_square))
    current_space += 1
    print(spaces)
    spaces.append(determine_diagonal(current_square, current_space, spaces, difference_square))
    current_space += 1
    # current_square += 2
    # difference_square = 16
    print(spaces)
    spaces.append(determine_diagonal(current_square, current_space, spaces, difference_square))
    current_space += 1
    print(spaces)
    spaces.append(determine_diagonal(current_square, current_space, spaces, difference_square))
    current_space += 1
    print(spaces)
    spaces.append(determine_diagonal(current_square, current_space, spaces, difference_square))
    current_space += 1
    print(spaces)
    spaces.append(determine_diagonal(current_square, current_space, spaces, difference_square))
    current_space += 1
    print(spaces)
    spaces.append(determine_diagonal(current_square, current_space, spaces, difference_square))
    current_space += 1
    print(spaces)
    spaces.append(determine_diagonal(current_square, current_space, spaces, difference_square))
    current_space += 1
    print(spaces)
    spaces.append(determine_diagonal(current_square, current_space, spaces, difference_square))
    current_space += 1
    print(spaces)
    spaces.append(determine_diagonal(current_square, current_space, spaces, difference_square))
    current_space += 1
    print(spaces)


"""
Max spaces to add together is 4:

4 - 3 spaces to the right, space before
4 - Space next to diagonal, space before, space 2 before, diagonal of previous square, space before previous square diagonal
3 - Space before diagonal, space before, 2 spaces in previous square
3 - Bottom right diagonal, space before, above, diagonal of previous square
2 - Diagonal of square, space before, diagonal of previous square
2 - Beginning of new square, space before, beginning of last square
"""
def part2(target_value):
    spaces = [1, 1, 2, 4, 5, 10, 11, 23, 25]
    current_square = 5
    current_space = 10
    value = 0
    difference_square = 9
    square_max = current_square * current_square

    while value < target_value:
        value = determine_diagonal(current_square, current_space, spaces, difference_square)
        spaces.append(value)
        current_space += 1
        if current_space > square_max:
            current_square += 2
            difference_square += 8
            square_max = current_square * current_square

    print(value)


part1(day3_input)
# test_part2(day3_input)
part2(day3_input)
