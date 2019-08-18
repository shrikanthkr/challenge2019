require "solution/version"
require "solution/helpers/csv_helper"
require "solution/delivery_manager"

module Solution
  class Error < StandardError
  end

  theatres_map = CsvHelper.parse_partners_csv
  capacities_map = CsvHelper.read_capacities

  delivery_manager = DeliveryManager.new(theatres_map, capacities_map)
  inputs = CsvHelper.parse_input
  expected_outputs = delivery_manager.deliver(inputs)
  total_output_cost = delivery_manager.total_cost(expected_outputs)
  exceeded_partners = delivery_manager.check_for_capacities(expected_outputs)
  delivery_manager.compute_final_output(expected_outputs, total_output_cost, exceeded_partners)
  CsvHelper.write_output(expected_outputs)

end
