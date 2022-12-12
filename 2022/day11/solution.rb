lines = File.readlines('./input.txt').map(&:strip)

class Monkey
  attr_accessor :monkey_number
  attr_accessor :items
  attr_accessor :operation
  attr_accessor :test
  attr_accessor :if_true_throw
  attr_accessor :if_false_throw
  attr_accessor :count_of_inspected_items

  def initialize(monkey_number, items, operation, test, if_true_throw, if_false_throw)
    self.monkey_number = monkey_number
    self.items = items
    self.operation = operation
    self.test = test
    self.if_true_throw = if_true_throw
    self.if_false_throw = if_false_throw
    self.count_of_inspected_items = 0
  end

  def to_s
    "Monkey #{monkey_number}: #{items}\n#{operation}\ndivisible by #{test} ? #{if_true_throw} : #{if_false_throw}"
  end
end

class Operation
  attr_accessor :first_operand
  attr_accessor :operator
  attr_accessor :second_operand

  def initialize(first_operand, operator, second_operand)
    self.first_operand = first_operand
    self.operator = operator
    self.second_operand = second_operand
  end

  def do_operation(old_value)
    first_operand_value = case self.first_operand
    when 'old'
      old_value
    else
      self.first_operand.to_i
    end

    second_operand_value = case self.second_operand
    when 'old'
      old_value
    else
      self.second_operand.to_i
    end

    case self.operator
    when '+'
      first_operand_value + second_operand_value
    when '-'
      first_operand_value - second_operand_value
    when '*'
      first_operand_value * second_operand_value
    when '/'
      first_operand_value / second_operand_value
    end
  end

  def to_s
    "Operation { #{first_operand} #{operator} #{second_operand} }"
  end
end

def build_monkeys(input_lines)
  monkeys = []

  input_lines.each_slice(7) do |tuple|
    monkey_number = tuple[0].scan(/\d+/).first
    starting_items = tuple[1].scan(/\d+/).map(&:to_i)
    first_operand, operator, second_operand = convert_operation(tuple[2].sub('Operation: ', ''))

    # currentely just a divisible check
    test = tuple[3].scan(/\d+/).first.to_i
    if_true_throw = tuple[4].scan(/\d+/).first.to_i
    if_false_throw = tuple[5].scan(/\d+/).first.to_i

    operation = Operation.new(first_operand, operator, second_operand)
    monkey = Monkey.new(
      monkey_number,
      starting_items,
      operation,
      test,
      if_true_throw,
      if_false_throw
    )
    monkeys.push(monkey)
  end

  monkeys
end

def convert_operation(operation_string)
  operation_string_split = operation_string.split(' ')
  first_operand = operation_string_split[2]
  operator = operation_string_split[3]
  second_operand = operation_string_split[4]

  [first_operand, operator, second_operand]
end

monkeys = build_monkeys(lines)

(1..20).each do |_|
  monkeys.each do |monkey|
    monkey_items_to_evaluate = monkey.items
    monkey.items = []
    monkey_items_to_evaluate.each do |item|
      operation_result = monkey.operation.do_operation(item)
      boredom_result = (operation_result / 3).floor
      test_result = boredom_result % monkey.test == 0
      target_monkey_number = test_result ? monkey.if_true_throw : monkey.if_false_throw
      monkeys[target_monkey_number].items.push(boredom_result)
      monkey.count_of_inspected_items += 1
    end
  end
end

counts = monkeys.map { |monkey| monkey.count_of_inspected_items }
most_active_monkey_counts = counts.max(2)
pp most_active_monkey_counts[0] * most_active_monkey_counts[1]

monkeys = build_monkeys(lines)

highest_divisor = monkeys.map(&:test).reduce(&:*)

(1..10_000).each do |i|
  monkeys.each do |monkey|
    monkey_items_to_evaluate = monkey.items
    monkey.items = []
    monkey_items_to_evaluate.each do |item|
      operation_result = monkey.operation.do_operation(item)
      operation_result = operation_result % highest_divisor
      test_result = operation_result % monkey.test == 0
      target_monkey_number = test_result ? monkey.if_true_throw : monkey.if_false_throw
      monkeys[target_monkey_number].items.push(operation_result)
      monkey.count_of_inspected_items += 1
    end
  end
end

counts = monkeys.map { |monkey| monkey.count_of_inspected_items }
most_active_monkey_counts = counts.max(2)
pp most_active_monkey_counts[0] * most_active_monkey_counts[1]
