require 'colorize'
require 'byebug'
class Tile
  attr_reader :value
  def initialize(value = 0, given = false)
    @value = value
    @given = given
  end

  def value=(num)
    @value = num unless @given
  end

  def to_s
    string = @value.to_s
    string = " " if @value == 0

    @given ? string.colorize(:red) : string
  end

end
