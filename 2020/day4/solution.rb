require 'rb-readline'
require 'pry'

class Identification
  attr_reader :birth_year, :issue_year, :expiration_year, :height, :hair_color, :eye_color, :passport_id, :country_id

  NOT_PROVIDED = :not_provided

  def initialize(birth_year, issue_year, expiration_year, height, hair_color, eye_color, passport_id, country_id)
    @birth_year = birth_year
    @issue_year = issue_year
    @expiration_year = expiration_year
    @height = height
    @hair_color = hair_color
    @eye_color = eye_color
    @passport_id = passport_id
    @country_id = country_id
  end

  def all_required_fields_present?
    birth_year != NOT_PROVIDED &&
      issue_year != NOT_PROVIDED &&
      expiration_year != NOT_PROVIDED &&
      height != NOT_PROVIDED &&
      hair_color != NOT_PROVIDED &&
      eye_color != NOT_PROVIDED &&
      passport_id != NOT_PROVIDED
  end

  def all_fields_valid?
    birth_year.match?(/^(19[2-9][0-9]|200[0-2])$/) &&
      issue_year.match?(/^(201[0-9]|2020)$/) &&
      expiration_year.match?(/^(202[0-9]|2030)$/) &&
      valid_height &&
      hair_color.match?(/^#[0-9a-f]{6}$/) &&
      eye_color.match?(/^(amb|blu|brn|gry|grn|hzl|oth)$/) &&
      passport_id.match?(/^[0-9]{9}$/)
  end

  def valid_height
    if height.end_with?('cm')
      height.match?(/^(1[5-8][0-9]|19[0-3])cm$/)
    elsif height.end_with?('in')
      height.match?(/^(59|6[0-9]|7[0-6])in$/)
    else
      false
    end
  end

  class << self
    def create_from_hash(identification_information)
      Identification.new(
        identification_information[:birth_year] || Identification::NOT_PROVIDED,
        identification_information[:issue_year] || Identification::NOT_PROVIDED,
        identification_information[:expiration_year] || Identification::NOT_PROVIDED,
        identification_information[:height] || Identification::NOT_PROVIDED,
        identification_information[:hair_color] || Identification::NOT_PROVIDED,
        identification_information[:eye_color] || Identification::NOT_PROVIDED,
        identification_information[:passport_id] || Identification::NOT_PROVIDED,
        identification_information[:country_id] || Identification::NOT_PROVIDED,
      )
    end
  end
end

def parse_line_and_add_to_hash(line, identification_information)
  line_information = line.split(' ')

  line_information.each do |information|
    split_info = information.split(':')
    key = split_info[0]
    value = split_info[1]

    case key
    when 'byr'
      identification_information[:birth_year] = value
    when 'iyr'
      identification_information[:issue_year] = value
    when 'eyr'
      identification_information[:expiration_year] = value
    when 'hgt'
      identification_information[:height] = value
    when 'hcl'
      identification_information[:hair_color] = value
    when 'ecl'
      identification_information[:eye_color] = value
    when 'pid'
      identification_information[:passport_id] = value
    when 'cid'
      identification_information[:country_id] = value
    end
  end
end

lines = File.readlines('./input.txt')

identifications = []

# combine passport identification lines
current_identification_information = {}
lines.each do |line|
  if line == "\n"
    identifications.push(Identification.create_from_hash(current_identification_information))
    current_identification_information = {}
  else
    parse_line_and_add_to_hash(line, current_identification_information)
  end
end

identifications.push(Identification.create_from_hash(current_identification_information))

identifications_with_required_fields = identifications.select { |id| id.all_required_fields_present? }
puts identifications_with_required_fields.size

identifications_with_valid_fields = identifications_with_required_fields.select { |id| id.all_fields_valid? }
puts identifications_with_valid_fields.size
