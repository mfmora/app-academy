require_relative 'card'
class Board

SIZE = 4

  def initialize(deck = create_deck)
    @deck = deck
    @grid = Array.new(SIZE) {Array.new(SIZE)}
    setup
  end

  def hide(pos)
    self[pos].hide
  end

  def grid
    @grid
  end

  def setup
    populate
  end

  def size
    SIZE
  end

  def create_deck
    @deck = []
    (0..7).each do |number|
      @deck << Card.new(number)
      @deck << Card.new(number)
    end
    @deck
  end

  def won?
    @grid.each do |row|
      row.each do |card|
        return false unless card.revealed?
      end
    end
    true
  end

  def match_cards?(pos_one, pos_two)
    self[pos_one].value == self[pos_two].value
  end

  def reveal(pos)
    unless self[pos].revealed?
      self[pos].reveal
      self[pos].value
    end

  end

  def card_revealed?(pos)
    self[pos].revealed?
  end

  def render
    @grid.each do |row|
      p row.map{ |card| card.to_s}
    end
  end

  def populate
    @deck.shuffle.each do |card|
      self[get_random] = card
    end
  end

  def get_random
    pos = random_position
    until empty?(pos)
      pos = random_position
    end
    pos
  end

  def random_position
    [rand(0...@grid.length), rand(0...@grid.length)]
  end

  def empty?(pos)
    self[pos].nil?
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @grid[x][y] = val
  end

end
