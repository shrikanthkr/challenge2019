class SizeSlab
  attr_accessor :range, :min_cost, :cost_per_gb
  def initialize(range_value, min_cost, cost_per_gb)

    range = range_value.split('-')
    @range = Range.new range[0].to_i, range[1].to_i
    @min_cost = min_cost
    @cost_per_gb = cost_per_gb
  end

  def to_json
    {range: @range.to_json, min_cost: min_cost, cost_per_gb: cost_per_gb}
  end
end