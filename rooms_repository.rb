require "csv"
require_relative "room"

class RoomsRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @rooms = []
    load_csv
  end

  def find(id)
    @rooms.find { |room| room.id == id.to_i }
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      row[:id]    = row[:id].to_i          # Convert column to Fixnum
      @rooms << Room.new(row)
    end
  end
end

rooms_repository = RoomsRepository.new("rooms.csv")
p rooms_repository
