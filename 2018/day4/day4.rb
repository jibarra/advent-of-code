# This could probably be split to a Guard class with many GuardShifts

class GuardShift
  # Time assumed to start at midnight (00:00), negative is before, positive is after
  @shift_start
  @awake_times
  @asleep_times
  @day

  attr_accessor :id, :shift_start, :awake_times, :asleep_times, :day

  def initialize
    @awake_times = []
    @asleep_times = []
  end

  # It's assumed the shift is for an hour, 00-59
  def total_minutes_asleep
    minutes_asleep = 0
    @asleep_times.each_with_index do |time, i|
      minutes_asleep = @awake_times[i] - @asleep_times[i]
    end
    minutes_asleep
  end
@awake_times=[8, 43], @asleep_times=[7, 15],
  def asleep_at?(minute)
    @asleep_times.each_with_index do |time, i|
      return true if @asleep_times[i] == minute

      return false if @awake_times[i] == minute

      if @asleep_times[i] < minute && @awake_times[i] > minute
        return true
      end
    end

    return false
  end

  def to_s
    "{GuardShift: shift_start=#{@shift_start}, awake_times=#{@awake_times}, asleep_times=#{@asleep_times}}, day=#{@day}}"
  end
end

class Guard
  @id
  @guard_shifts
  @total_minutes_asleep

  attr_accessor :id, :guard_shifts, :total_minutes_asleep

  def initialize
    @guard_shifts = []
    @total_minutes_asleep = 0
  end

  # It's assumed the shift is for an hour, 00-59
  def total_minutes_asleep
    return @total_minutes_asleep if @total_minutes_asleep > 0
    @total_minutes_asleep = 0
    @guard_shifts.each do |shift|
      @total_minutes_asleep += shift.total_minutes_asleep
    end
    @total_minutes_asleep
  end

  def most_asleep_minute
    all_asleep_minutes = []
    all_awake_minutes = []
    @guard_shifts.each do |shift|
      shift.awake_times.each do |time|
        all_awake_minutes << time
      end
      shift.asleep_times.each do |time|
        all_asleep_minutes << time
      end
    end
    all_asleep_minutes = all_asleep_minutes.sort
    all_awake_minutes = all_awake_minutes.sort

    max_count = 0
    max_count_minute = 0
    count = 0
    i_asleep = 0
    i_awake = 0
    (0..59).each do |minute|
      while all_asleep_minutes[i_asleep] == minute do
        count += 1
        i_asleep += 1
      end
      while all_awake_minutes[i_awake] == minute do
        count -= 1
        i_awake += 1
      end

      if count > max_count
        max_count = count
        max_count_minute = minute
      end
    end

    max_count_minute
  end

  def to_s
    "{Guard: id=#{@id}, guard_shifts=#{@guard_shifts}, total_minutes_asleep=#{@total_minutes_asleep}}"
  end
end

lines = File.readlines('./input.txt')

current_shift = nil
# id -> guard
guards = {}
# day -> shift
shifts = {}

lines = lines.sort
current_guard = nil
current_shift = nil
lines.each do |line|
  day = line.split(' ')[0].tr('[', '')
  time = line.split(' ')[1].tr(']', '').split(':')
  hour = time[0].to_i
  minute = time[1].to_i

  if line.include? 'begins shift'
    id = line.split(' ')[3].tr('#', '').to_i
    current_guard = guards[id]
    if current_guard.nil?
      current_guard = Guard.new
      current_guard.id = id
      guards[id] = current_guard
    end
  end

  shift = shifts[day]
  if shift.nil?
    shift = GuardShift.new
    shift.day = day
    shifts[day] = shift
    current_guard.guard_shifts << shift
  end

  if line.include? 'falls asleep'
    shift.asleep_times << minute
  end

  if line.include? 'wakes up'
    shift.awake_times << minute
  end
end

max_asleep_minutes = 0
max_asleep_guard = nil

guards.each do |id, guard|
  asleep_time = guard.total_minutes_asleep

  if max_asleep_minutes < asleep_time
    max_asleep_minutes = asleep_time
    max_asleep_guard = guard
  end
end

puts max_asleep_guard
puts max_asleep_guard.most_asleep_minute
puts guards
# puts max_asleep_guard.most_asleep_minute * max_asleep_guard.id
