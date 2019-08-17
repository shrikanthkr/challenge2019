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
      min_slab_partner_hash = min_slab_partner_hash(theatres_map[input.theatre_id], input)
      if min_slab_partner_hash[:min_cost].nil?
        outputs << Output.new(input.id, false, '', '')
      else
        outputs << Output.new(input.id, true, min_slab_partner_hash[:min_cost], min_slab_partner_hash[:partner])
      end
    end
    outputs
  end

  def min_slab_partner_hash(theatre, input)
    min_hash = {}

    theatre.partners.each do |partner_id, partner|
      partner.size_slabs.each do |slab|
        total_data = input.total_data.to_i
        next unless (slab.range.include? total_data) && (capacities_hash[partner_id].to_i >= total_data)


        cost = slab.cost_per_gb * input.total_data
        expected_value = [cost, slab.min_cost].max
        if min_hash[:min_cost].nil?
          min_hash[:min_cost] = expected_value
          min_hash[:partner] = partner_id
        else

          if expected_value < min_hash[:min_cost]
            min_hash[:min_cost] = expected_value
            min_hash[:partner] = partner_id
          end
        end
      end
    end
    min_hash
  end

end