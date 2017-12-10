import re


class Program:
    def __init__(self):
        self.name = ""
        self.weight = 0
        self.stacked_program_names = []
        self.stacked_programs = []
        self.stack_weight = 0

    def __str__(self):
        return ("Program{name=" + self.name
                + ", weight=" + str(self.weight)
                + ", stacked_program_names=" + str(self.stacked_program_names)
                + ", stacked_programs=" + str(self.stacked_programs)
                + ", stack_weight=" + str(self.stack_weight)
                + "}")

    def __repr__(self):
        return str(self)

    def parse_program(self, program_string):
        self.name = re.search('^[a-zA-Z]+', program_string).group(0)
        self.weight = int(re.search('\d+', program_string).group(0))
        programs_found = re.search('[ a-zA-Z,]+$', program_string)
        if programs_found:
            programs = programs_found.group(0).strip()
            self.stacked_program_names = programs.split(", ")


def read_file(file_name):
    data = ""
    with open(file_name, "r") as file:
        data = file.read()
    return data


def parse_input():
    program_lines = read_file("day7_input.txt").split("\n")
    programs = []
    for program_line in program_lines:
        program = Program()
        program.parse_program(program_line)
        programs.append(program)
    return programs


def get_non_top_programs(programs):
    non_top_programs = []
    for program in programs:
        if program.stacked_program_names:
            non_top_programs.append(program)
    return non_top_programs


def part1():
    print("test")
    programs = parse_input()
    non_top_programs = get_non_top_programs(programs)
    stacked_programs = set()
    for program in non_top_programs:
        for stacked_program in program.stacked_program_names:
            stacked_programs.add(stacked_program)

    for program in non_top_programs:
        if program.name not in stacked_programs:
            print(program)


def calculate_stack_weight(programs_map, program_name):
    program = programs_map.get(program_name)

    if not program.stacked_program_names:
        program.stack_weight = program.weight
        return program.stack_weight
    else:
        stack_weight = 0
        for stacked_program_name in program.stacked_program_names:
            stack_weight += calculate_stack_weight(programs_map, stacked_program_name)
        program.stack_weight = stack_weight + program.weight
        return program.stack_weight


"""
To find the unbalanced program:

Pass down the expected_stack_weight. expected_stack_weight for higher programs is program.stack_weight - program.weight

if program.stack_weight == expected_stack_weight:
    return None
else:
    TODO: the below is not the correct expected stack weight
    calculate expected stack weight (program.stack_weight - program.weight)
    loop through stacked programs
        if all equal weight, return this program name (it breaks the stack)
        if all not equal weight, recursion with this expected stack weight
"""
# def find_unbalanced_program(programs_map, program_name, expected_stack_weight, is_first):
#     program = programs_map.get(program_name)
#     print(program, expected_stack_weight)
#     if program.stack_weight == expected_stack_weight and not is_first:
#         return None
#     elif not program.stacked_program_names:
#         return program.name, expected_stack_weight - program.weight
#     else:
#         new_expected_stack_weight = program.stack_weight - program.weight
#         stacked_programs = []
#         for stacked_program_name in program.stacked_program_names:
#             stacked_programs.append(programs_map.get(stacked_program_name))
#         is_all_equal = True
#         for i in range(0, len(stacked_programs) - 1):
#             if stacked_programs[i].weight != stacked_programs[i + 1].weight:
#                 is_all_equal = False
#         if is_all_equal:
#             fixed_weight = (expected_stack_weight - program.stack_weight) + program.weight
#             print(expected_stack_weight)
#             print(program.stack_weight)
#             print(program.weight)
#             return program.name, fixed_weight
#         else:
#             result = None
#             if len(stacked_programs) == 2:
#                 result = find_unbalanced_program(programs_map, stacked_program.name, new_expected_stack_weight, False)
#             for stacked_program in stacked_programs:
#                 result = find_unbalanced_program(programs_map, stacked_program.name, new_expected_stack_weight, False)
#                 if result:
#                     return result
#             return result

"""
count_weight1 = 1
weight1 = programs[0].weight
weight2 = -1 *don't need*
weight2_index = -1
for rest of programs
    compare programs[i].weight to weight1 and increase count if equal
    if different, set weight2_index
if weight1 count == 1: programs[0] is invalid
else programs[weight2_index] is invalid
"""

def find_unbalanced_program(programs_map, program_name):
    program = programs_map.get(program_name)
    # Handle leaf nodes
    if not program.stacked_program_names:
        print("1")
        return None
    # Handle 2 splits differently
    elif len(program.stacked_program_names) == 2:
        print("2")
        return None
    else:
        stacked_programs = []
        for stacked_program_name in program.stacked_program_names:
            stacked_programs.append(programs_map.get(stacked_program_name))
        count_weight1 = 0
        weight2_index = -1
        for i in range(0, len(stacked_programs)):
            if stacked_programs[i].stack_weight == stacked_programs[0].stack_weight:
                count_weight1 += 1
            else:
                weight2_index = i
        if count_weight1 == len(stacked_programs):
            return program.name
        elif count_weight1 == 1:
            invalid_program_stack = stacked_programs[0]
        else:
            invalid_program_stack = stacked_programs[weight2_index]
        return find_unbalanced_program(programs_map, invalid_program_stack.name)




def part2():
    bottom_program_name = "dgoocsw"
    programs = parse_input()
    programs_map = {}
    for program in programs:
        programs_map[program.name] = program
    calculate_stack_weight(programs_map, bottom_program_name)
    print(programs)
    print(programs_map.get("ifajhb"))
    print(programs_map.get("gqmls"))
    print(programs_map.get("sgmbw"))
    print(programs_map.get("ddkhuyg"))
    print(programs_map.get("rhqocy"))

    print("start find_unbalanced_program")

    # bottom_program = programs_map.get(bottom_program_name)
    unbalanced_program_name = find_unbalanced_program(programs_map, bottom_program_name)
    print(unbalanced_program_name)
    print(programs_map.get(unbalanced_program_name))
    # -8
    print(programs_map.get("marnqj"), programs_map.get("moxiw"), programs_map.get("sxijke"), programs_map.get("ojgdow"), programs_map.get("fnlapoh"))
    # print(programs_map.get("upair"), programs_map.get("mkrrlbv"), programs_map.get("vqkwlq"), programs_map.get("wsrmfr"))


part1()
part2()
