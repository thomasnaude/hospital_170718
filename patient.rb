class Patient
  attr_reader :name
  attr_accessor :room, :id

  def initialize(args = {})
    @name = args[:name]
    @cured = args[:cured] || false
    @id = args[:id]
  end

  def cure!
    @cured = true
  end

  def cured?
    @cured
  end
end
