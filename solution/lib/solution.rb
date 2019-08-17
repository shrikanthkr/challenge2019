require "solution/version"
require "solution/helpers/csv_helper"
require "solution/delivery_manager"

module Solution
  class Error < StandardError;
  end

  theatres_map = CsvHelper.parse_partners_csv
  capacities_map = CsvHelper.read_capacities

  delivery_manager = DeliveryManager.new(theatres_map, capacities_map)
  inputs = CsvHelper.parse_input
  outputs = delivery_manager.deliver(inputs)
  CsvHelper.write_output(outputs)

end
