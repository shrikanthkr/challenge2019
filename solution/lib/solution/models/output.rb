class Output
  attr_accessor :id, :possibility, :partner_id, :cost, :sorted_partner_array, :theatre_id, :total_data


  def initialize(id, total_data)
    @id = id
    @possibility = false
    @total_data = total_data
    @partner_id = ""
    @theatre_id = ""
    @sorted_partner_array = []
  end


end