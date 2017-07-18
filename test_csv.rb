require "csv"
require_relative "patient"

patients = []
csv_options = { headers: :first_row, header_converters: :symbol }
CSV.foreach("patients.csv", csv_options) do |row|
  row[:id]    = row[:id].to_i          # Convert column to Fixnum
  row[:cured] = row[:cured] == "true"  # Convert column to boolean
  patients << Patient.new(row)
end

p patients
