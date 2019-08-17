class Output
  attr_accessor :id, :possibility, :partner_id, :cost, :sorted_partner_array


  def initialize(id)
    @id = id
    @possibility = false
    @partner_id = ""
    @sorted_partner_array = []
  end


end