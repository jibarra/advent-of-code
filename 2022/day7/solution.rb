lines = File.readlines('./input.txt').map(&:strip)

class FileSystem
end

class File
  attr_accessor :name
  attr_accessor :size
  attr_accessor :parent_directory

  def initialize(name, size, parent_directory)
    @name = name
    @size = size
    @parent_directory = parent_directory
  end
end

class Directory
  attr_accessor :name
  attr_accessor :parent_directory
  attr_accessor :files_and_directories
  attr_accessor :computed_size

  def initialize(name, parent_directory)
    @name = name
    @parent_directory = parent_directory
    @files_and_directories = nil
    @computed_size = nil
  end

  def find_child_directory(child_directory_name)
    files_and_directories.find do |file_or_directory|
      file_or_directory.is_a?(Directory) && file_or_directory.name == child_directory_name
    end
  end

  def compute_size
    @computed_size = 0
    files_and_directories.each do |file_or_directory|
      case file_or_directory
      when Directory
        if !file_or_directory.computed_size
          file_or_directory.compute_size
        end
        @computed_size += file_or_directory.computed_size
      when File
        @computed_size += file_or_directory.size
      else
        raise ArgumentError, "Invalid object: #{file_or_directory}"
      end
    end
  end
end

def executed_command?(line)
  line.starts_with?('$')
end

def is_command(line)
  split_line = line.split(' ')
  split_line[0] == '$'
end

# Returns the command and potential directory
def command(line)
  split_line = line.split(' ')
  [split_line[1], split_line[2]]
end

def ls_result(line)
  split_line = line.split(' ')
  [split_line[0], split_line[1]]
end

# Build directory structure from commands and outputs
root = Directory.new('/', nil)
current_directory = root
lines.each do |line|
  if is_command(line)
    command, potential_directory = command(line)

    if command == 'ls'
      # intentially skipped
    else
      if potential_directory == '/'
        current_directory = root
      elsif potential_directory == '..'
        current_directory = current_directory.parent_directory
      else
        current_directory = current_directory.files_and_directories.find { |fd| fd.name == potential_directory }
      end
    end
  else
    dir_or_size, name = ls_result(line)
    current_directory.files_and_directories ||= []
    if dir_or_size == 'dir'
      current_directory.files_and_directories.push(
        Directory.new(
          name,
          current_directory
        )
      )
    else
      current_directory.files_and_directories.push(
        File.new(
          name,
          dir_or_size.to_i,
          current_directory
        )
      )
    end
  end
end

# Part 1
root.compute_size
directories_at_most_100000 = []
directories = [root]
while(directories.size > 0)
  current_directory = directories.pop
  if current_directory.computed_size <= 100_000
    directories_at_most_100000.push(current_directory)
  end

  current_directory.files_and_directories.each do |file_or_directory|
    if file_or_directory.is_a?(Directory)
      directories.push(file_or_directory)
    end
  end
end

pp directories_at_most_100000.sum { |directory| directory.computed_size }
