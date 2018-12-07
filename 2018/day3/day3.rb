class FabricClaim
  @top_left_row
  @top_left_col
  @width
  @height
  @id

  attr_accessor :top_left_row, :top_left_col, :width, :height, :id

  def to_s
    "{FabricClaim: top_left_row=#{@top_left_row}, top_left_col=#{@top_left_col}, width=#{@width}, height=#{@height}, id=#{@id}"
  end
end

lines = File.readlines('./input.txt')

fabric_claims = []
max_row = 0
max_col = 0

lines.each do |line|
  split_line = line.split(' ')

  fabric_claim = FabricClaim.new

  fabric_claim.id = split_line[0].tr('#', '')

  coordinate = split_line[2].tr(':', '').split(',')
  fabric_claim.top_left_row = coordinate[0].to_i
  fabric_claim.top_left_col = coordinate[1].to_i

  size = split_line[3].split('x')
  fabric_claim.width = size[0].to_i
  fabric_claim.height = size[1].to_i

  edge_row = fabric_claim.top_left_row + fabric_claim.width
  edge_col = fabric_claim.top_left_col + fabric_claim.height

  max_row = edge_row if max_row < edge_row
  max_col = edge_col if max_col < edge_col

  fabric_claims << fabric_claim
end

fabric_squares = []

(0..max_row).each do
  temp = []
  (0..max_col).each do
    temp << 0
  end
  fabric_squares << temp
end

fabric_claims.each do |fabric_claim|
  (fabric_claim.top_left_row..(fabric_claim.top_left_row + fabric_claim.width - 1)).each do |row|
    (fabric_claim.top_left_col..(fabric_claim.top_left_col + fabric_claim.height - 1)).each do |col|
      fabric_squares[row][col] += 1
    end
  end
end

count = 0
fabric_squares.each do |row|
  row.each do |square|
    count += 1 if square >= 2
  end
end

puts "part 1 count: #{count}"

bad_claims = []

fabric_claims.each do |fabric_claim|
  (fabric_claim.top_left_row..(fabric_claim.top_left_row + fabric_claim.width - 1)).each do |row|
    (fabric_claim.top_left_col..(fabric_claim.top_left_col + fabric_claim.height - 1)).each do |col|
      bad_claims << fabric_claim if (fabric_squares[row][col] > 1 && !bad_claims.include?(fabric_claim))
    end
  end
end

puts fabric_claims - bad_claims