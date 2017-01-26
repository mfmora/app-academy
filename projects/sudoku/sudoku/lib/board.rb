require_relative 'tile'
require 'byebug'
class Board

  def self.from_file(file_name)
    res = []
    File.readlines(file_name).map do |line|
      line_array = []
      line.chomp.split("").each do |num|
        given =  num.to_i > 0 ? true : false
        line_array << Tile.new(num.to_i, given)
      end
      res << line_array
    end
    res
  end

  def initialize(grid = Board.from_file("puzzle1.txt"))
    @grid = grid
  end

  def render
    string_array = []
    @grid.map do |row|
      string_row = "|"
      row_display = row.map do |el|
        string_row += "#{el.to_s}|"
      end
      string_array << string_row
    end
    puts string_array
  end

end
