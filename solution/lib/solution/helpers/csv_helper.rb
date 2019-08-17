# frozen_string_literal: true

require 'csv'
require 'solution/models/theatre'
require 'solution/models/partner'
require 'solution/models/size_slab'
require 'solution/models/input'
require 'json'
# A helper csv reader class which parses inputs from different csv files
class CsvHelper

  @@fixtures = File.dirname(__FILE__) + '/../fixtures/'

  def self.parse_partners_csv

    theatre_map = {}
    partners_file = File.read("#{@@fixtures}partners.csv")

    partners = CSV.parse(partners_file)
    partners.each_with_index do |row, i|
      next if i.zero?

      current_row = current_partner_file_hash(row)
      theatre = theatre_map[current_row[:theatre_id]] || Theatre.new
      partner = theatre.partners[current_row[:partner_id]] || Partner.new
      size_slab = SizeSlab.new current_row[:size_slab], current_row[:min_cost],
                               current_row[:cost_per_gb]
      partner.size_slabs << size_slab
      theatre.partners[current_row[:partner_id]] = partner
      theatre_map[current_row[:theatre_id]] = theatre
    end
    theatre_map
  end

  def self.current_partner_file_hash(row)
    current_row = {}
    current_row[:theatre_id] = row[0].strip
    current_row[:size_slab] = row[1].strip
    current_row[:min_cost] = row[2].to_i
    current_row[:cost_per_gb] = row[3].to_i
    current_row[:partner_id] = row[4].strip
    current_row
  end

  def self.parse_input
    inputs = []
    inputs_file = File.read(@@fixtures + 'input.csv')
    inputs_table = CSV.parse(inputs_file)
    inputs_table.each_with_index do |row, i|
      inputs << Input.new(row[0].strip, row[1].to_i, row[2].strip)
    end
    inputs
  end

  def self.read_capacities
    capacities_hash = {}
    capacities_file = File.read(@@fixtures + 'capacities.csv')
    capacities_table = CSV.parse(capacities_file)
    capacities_table.each_with_index do |row, i|
      next if i.zero?

      capacities_hash[row[0].strip] = row[1.to_i]
    end
    capacities_hash
  end

  def self.write_output outputs
    CSV.open("myfile.csv", "w") do |csv|
      outputs.each do |output|
        csv << [output.id, output.possibility, output.cost, output.partner_id]
      end
    end
  end
end
