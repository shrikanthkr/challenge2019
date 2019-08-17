

class Partner
  attr_accessor :size_slabs

  def initialize
    @size_slabs = []
  end

  def to_json
    {
        size_slabs: @size_slabs
    }
  end
end