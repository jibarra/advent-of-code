import re

class RegisterInstruction:
    def __init__(self):
        self.register_change_name = ""
        self.is_increment = None
        self.change_value = 0
        self.comparision_string = ""
        self.comparison_register = ""
        self.comparison_operator = ""
        self.comparison_value = 0

    def __str__(self) -> str:
        return ("RegisterInstruction{"
                + "register_change_name=" + self.register_change_name
                + ", is_increment=" + str(self.is_increment)
                + ", change_value=" + str(self.change_value)
                + ", comparison_string=" + self.comparision_string
                + ", comparison_register=" + self.comparison_register
                + ", comparison_operator=" + self.comparison_operator
                + ", comparison_value=" + str(self.comparison_value)
                + "}")

    def __repr__(self):
        return str(self)

    def parse_register_input(self, register_input):
        self.register_change_name = re.search('^[a-zA-Z]+', register_input).group(0)
        increment_string = re.search('^[a-zA-Z]+ (inc|dec)', register_input).group(1)
        if increment_string == "inc":
            self.is_increment = True
        else:
            self.is_increment = False
        self.change_value = int(re.search('^[a-zA-Z ]+([0-9-]+)', register_input).group(1))
        self.comparision_string = re.search('if ([ a-zA-Z0-9<=>!-]+)$', register_input).group(1)
        self.parse_comparison_string(self.comparision_string)

    def parse_comparison_string(self, comparison_string):
        self.comparison_register = re.search('^[a-zA-Z]+', comparison_string).group(0)
        self.comparison_operator = re.search(' ([<>=!]+) ', comparison_string).group(1)
        self.comparison_value = int(re.search('[0-9-]+$', comparison_string).group(0))


def read_file(file_name):
    data = ""
    with open(file_name, "r") as file:
        data = file.read()
    return data


def parse_input():
    register_lines = read_file("day8_input.txt").split("\n")
    registers = []
    for register_line in register_lines:
        register = RegisterInstruction()
        register.parse_register_input(register_line)
        registers.append(register)
    return registers


def evaluate_register_comparison(register_map, register_instruction):
    evaluate_register_value = register_map.get(register_instruction.comparison_register)
    if register_instruction.comparison_operator == ">":
        return True if evaluate_register_value > register_instruction.comparison_value else False
    elif register_instruction.comparison_operator == ">=":
        return True if evaluate_register_value >= register_instruction.comparison_value else False
    elif register_instruction.comparison_operator == "<":
        return True if evaluate_register_value < register_instruction.comparison_value else False
    elif register_instruction.comparison_operator == "<=":
        return True if evaluate_register_value <= register_instruction.comparison_value else False
    elif register_instruction.comparison_operator == "==":
        return True if evaluate_register_value == register_instruction.comparison_value else False
    elif register_instruction.comparison_operator == "!=":
        return True if evaluate_register_value != register_instruction.comparison_value else False


def register_value_change(register_map, register_instruction):
    if register_instruction.is_increment is True:
        register_map[register_instruction.register_change_name] += register_instruction.change_value
    else:
        register_map[register_instruction.register_change_name] -= register_instruction.change_value


def part1():
    register_instructions = parse_input()
    register_map = {}
    for register_instruction in register_instructions:
        if register_instruction.register_change_name not in register_map:
            register_map[register_instruction.register_change_name] = 0
        if register_instruction.comparison_register not in register_map:
            register_map[register_instruction.comparison_register] = 0
        evaluation = evaluate_register_comparison(register_map, register_instruction)
        if evaluation is True:
            register_value_change(register_map, register_instruction)
    print(register_map)
    print(max(register_map, key=register_map.get))
    print(register_map[max(register_map, key=register_map.get)])


def part2():
    register_instructions = parse_input()
    register_map = {}
    highest_value = 0
    for register_instruction in register_instructions:
        if register_instruction.register_change_name not in register_map:
            register_map[register_instruction.register_change_name] = 0
        if register_instruction.comparison_register not in register_map:
            register_map[register_instruction.comparison_register] = 0
        evaluation = evaluate_register_comparison(register_map, register_instruction)
        if evaluation is True:
            register_value_change(register_map, register_instruction)
            if register_map[register_instruction.register_change_name] > highest_value:
                highest_value = register_map[register_instruction.register_change_name]
    print(highest_value)


part1()
part2()
