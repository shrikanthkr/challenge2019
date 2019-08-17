require 'solution/models/output'
class DeliveryManager
  attr_accessor :theatres_map, :capacities_hash

  def initialize(theatres_map, capacities_hash)
    @theatres_map = theatres_map
    @capacities_hash = capacities_hash
  end

  def deliver(inputs)
    outputs = []
    inputs.each do |input|
      outputs << expected_output(theatres_map[input.theatre_id], input)
    end
    outputs
  end

  def expected_output(theatre, input)
    total_data = input.total_data.to_i
    output = Output.new(input.id)
    theatre.partners.each do |partner_id, partner|
      partner.filtered_slabs(total_data).each do |slab|
        cost = (slab.cost_per_gb * input.total_data).to_i
        expected_value = [cost, slab.min_cost].max.to_i
        if output.cost.nil?
          output.cost = expected_value
          output.partner_id = partner_id
          output.possibility = true
        else

          if expected_value < output.cost
            output.cost = expected_value
            output.partner_id = partner_id
            output.possibility = true
          end
        end
      end
    end
    output
  end

end