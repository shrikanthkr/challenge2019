class Output
  attr_accessor :id, :possibility, :partner_id, :cost

  def initialize(id, possibility, partner_id, cost)
    @id = id
    @possibility = possibility
    @partner_id = partner_id
    @cost = cost
  end


end