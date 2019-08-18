class Theatre
  attr_accessor :partners, :id

  def initialize(id)
    @id = id
    @partners = {}
  end

  def to_json(*options)
    {partners: @partners}
  end

end