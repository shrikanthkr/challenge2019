class Input
  attr_accessor :id, :total_data, :theatre_id

  def initialize(id, total_data, theatre_id)
    @id = id
    @total_data = total_data
    @theatre_id = theatre_id
  end
end
