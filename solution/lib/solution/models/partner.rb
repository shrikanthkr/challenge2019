

class Partner
  attr_accessor :size_slabs

  def initialize
    @size_slabs = []
  end

  def filtered_slabs(total_data)
    size_slabs.select do |slab|
      slab.range.include? total_data
    end
  end
  def to_json
    {
        size_slabs: @size_slabs
    }
  end
end