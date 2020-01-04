require 'set'

lines = File.readlines('./input.txt').
  map { |line| line.gsub("\n", '') }
direct_orbits = lines.map { |line| line.split(')') }

def count_orbits(child_orbit_to_parent, child_name)
  current_node = child_name
  orbit_count = 0

  while(current_node != 'COM')
    orbit_count += 1
    current_node = child_orbit_to_parent[current_node]
  end

  orbit_count
end

def count_total_orbits(child_orbit_to_parent)
  total_orbit_count = 0
  child_orbit_to_parent.each do |child_name, parent_name|
    total_orbit_count += count_orbits(child_orbit_to_parent, child_name)
  end
  total_orbit_count
end

def build_child_orbit_to_parent_hash(direct_orbits)
  child_orbit_to_parent = direct_orbits.each_with_object({}) do |orbit, memo|
    parent = orbit[0]
    child = orbit[1]

    memo[child] = parent
  end
end

def shortest_path_count_between_you_and_santa(child_orbits_to_parents, parent_orbits_to_children)
  visited_nodes = Set.new
  to_visit_stack = []
  to_visit_stack << { 'YOU' => -1 }

  while !to_visit_stack.empty?
    node = to_visit_stack.pop
    name = node.keys.first
    count = node.values.first

    if name == 'SAN'
      return count - 1
    end

    visited_nodes.add(name)

    parent = child_orbits_to_parents[name]
    if !visited_nodes.include?(parent)
      to_visit_stack << { parent => count + 1 }
    end

    parent_orbits_to_children[name]&.each do |child|
      if !visited_nodes.include?(child)
        to_visit_stack << { child => count + 1 }
      end
    end
  end

  return -1
end

def test
  orbits = 'COM)B\nB)C\nC)D\nD)E\nE)F\nB)G\nG)H\nD)I\nE)J\nJ)K\nK)L'.
    split('\n').
    map { |line| line.split(')') }

  child_orbits_to_parents = build_child_orbit_to_parent_hash(orbits)

  puts 'count_orbits'
  puts count_orbits(child_orbits_to_parents, 'D') == 3
  puts count_orbits(child_orbits_to_parents, 'L') == 7
  
  puts 'count_total_orbits'
  puts count_total_orbits(child_orbits_to_parents) == 42

  orbits = 'COM)B\nB)C\nC)D\nD)E\nE)F\nB)G\nG)H\nD)I\nE)J\nJ)K\nK)L\nK)YOU\nI)SAN'.
    split('\n').
    map { |line| line.split(')') }

  child_orbits_to_parents = build_child_orbit_to_parent_hash(orbits)
  parent_orbits_to_children = child_orbits_to_parents.each_with_object({}) do |(child, parent), memo|
    memo[parent] ||= []
    memo[parent] << child
  end

  puts 'shortest_path_count_between_you_and_santa'
  puts shortest_path_count_between_you_and_santa(child_orbits_to_parents, parent_orbits_to_children) == 4
end

test

# Part 1
child_orbits_to_parents = build_child_orbit_to_parent_hash(direct_orbits)
puts count_total_orbits(child_orbits_to_parents)

# Part 2
# Maybe do a recursive solution to find the shortest direction.
# Would want a hash for child to parent and parent to child
# Could put it on a stack to make sure we do one step at a time
# And probably mark places we've already visited.
parent_orbits_to_children = child_orbits_to_parents.each_with_object({}) do |(child, parent), memo|
  memo[parent] ||= []
  memo[parent] << child
end

puts shortest_path_count_between_you_and_santa(child_orbits_to_parents, parent_orbits_to_children)
