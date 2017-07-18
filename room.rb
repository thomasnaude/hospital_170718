class Room
  attr_accessor :patients, :id

  def initialize(args = {})
    @capacity = args[:capacity] || 2
    @patients = args[:patients] || []
    @id = args[:id]
  end

  def full?
    @capacity == @patients.length
  end

  def add_patient(patient)
    fail Exception, "Room is full!" if full?
    patient.room = self
    @patients << patient
  end
end
