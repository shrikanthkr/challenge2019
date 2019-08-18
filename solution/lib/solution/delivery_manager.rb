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
    output = Output.new(input.id, total_data)
    output.theatre_id = theatre
    theatre.partners.each do |partner_id, partner|
      partner.filtered_slabs(total_data).each do |slab|
        cost = (slab.cost_per_gb * total_data).to_i
        expected_value = [cost, slab.min_cost].max.to_i
        assign_minimum_output(expected_value, output, partner)
        output.sorted_partner_array.insert(0, {partner: partner, cost: expected_value})

      end
    end
    output.sorted_partner_array.delete_if {|hash| hash[:partner].id == output.partner_id}
    output.sorted_partner_array = output.sorted_partner_array.sort_by {|hash| hash[:cost]}
    output
  end

  def total_cost(outputs)
    total = 0
    outputs.each do |output|
      next if output.cost.nil?

      total += output.cost
    end
    total
  end

  def check_for_capacities(outputs)
    partners_total_hash = {}
    excceded_partners = []
    outputs.each do |output|
      partners_total_hash[output.partner_id] = partners_total_hash[output.partner_id] || 0
      partners_total_hash[output.partner_id] = partners_total_hash[output.partner_id] + output.total_data
    end
    partners_total_hash.each do |id, total|
      next if id.nil? || id.empty?

      if capacities_hash[id].to_i < total
        excceded_partners << id
      end
    end
    excceded_partners
  end


  def compute_final_output(expected_outputs, total_output_cost, exceeded_partners)
    exceeded_partners.each do |partner|
      filtered_outputs = expected_outputs.each_with_index.map do |output, index|
        if output.partner_id == partner
          {index: index, output: output}
        end
      end
      suitable_partner = find_suitable_partner(filtered_outputs.compact(), total_output_cost)

      replace_index = suitable_partner[:original_index]
      new_output = expected_outputs[replace_index]
      new_output.partner_id = suitable_partner[:partner].id
      new_output.cost = suitable_partner[:output_cost]

    end
  end

  private

  def find_suitable_partner(original_outputs, initial_cost)

    next_min = {}
    original_outputs.each_with_index do |output_hash, index|
      output = output_hash[:output]
      partner_hash = output.sorted_partner_array[0]
      expected_cost = partner_hash[:cost] - output.cost + initial_cost
      if next_min[:cost].nil?
        next_min[:cost] = expected_cost
        next_min[:output_cost] = partner_hash[:cost]
        next_min[:partner] = partner_hash[:partner]
        next_min[:original_index] = output_hash[:index]
      else
        if next_min[:cost] < expected_cost
          next_min[:cost] = expected_cost
          next_min[:output_cost] = partner_hash[:cost]
          next_min[:partner] = partner_hash[:partner]
          next_min[:original_index] = output_hash[:index]
        end
      end
    end
    next_min
  end

  def assign_minimum_output(expected_value, output, partner)
    if output.cost.nil?
      output.cost = expected_value
      output.partner_id = partner.id
      output.possibility = true
    else

      if expected_value < output.cost
        output.cost = expected_value
        output.partner_id = partner.id
        output.possibility = true
      end
    end
  end

end