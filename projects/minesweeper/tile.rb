class Tile

  attr_reader :value, :revealed
  attr_accessor :flag_up

  def initialize(value)
    @value = value #:bomb :empty
    @revealed = false
    @flag_up = false
  end

  def reveal
    @revealed = true
  end

  




end
