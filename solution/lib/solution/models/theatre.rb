class Theatre
  attr_accessor :partners

  def initialize
    @partners = {}
  end

  def to_json(*options)
    { partners: @partners }
  end

end