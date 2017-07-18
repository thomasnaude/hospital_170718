require "csv"
require_relative "patient"
require_relative "rooms_repository"

class PatientsRepository
  def initialize(csv_file, rooms_repository)
    @csv_file = csv_file
    @patients = []
    @rooms_repository = rooms_repository
    load_csv
  end

  def add_patient(patient)
    patient.id = @next_id
    @patients << patient
    @next_id += 1
    save_csv
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      row[:id]    = row[:id].to_i          # Convert column to Fixnum
      row[:cured] = row[:cured] == "true"  # Convert column to boolean
      room = @rooms_repository.find(row[:room_id])
      patient = Patient.new(row)
      patient.room = room
      @patients << patient
    end
    @next_id = @patients.empty? ? 1 : @patients.last.id + 1
  end

  def save_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@csv_file, 'wb', csv_options) do |csv|
      csv << ['id', 'name', 'cured', 'room_id']
      @patients.each do |patient|
        csv << [patient.id, patient.name, patient.cured?, patient.room.id]
      end
    end
  end
end

rooms_repository = RoomsRepository.new("rooms.csv")

patients_repository = PatientsRepository.new("patients.csv", rooms_repository)
p patients_repository

room = rooms_repository.find(1)
jean = Patient.new(name: "jean")
jean.room = room
patients_repository.add_patient(jean)

# p jean
# p patients_repository
