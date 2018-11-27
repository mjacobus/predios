# frozen_string_literal: true

require 'csv'

class CsvParser
  def parse_file(file)
    [].tap do |rows|
      CSV.foreach(file, headers: true, encoding: 'utf-8') do |row|
        rows << DataBag.new(row.to_h)
      end
    end
  end
end
