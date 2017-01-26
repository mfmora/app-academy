require 'byebug'
class ComputerPlayer

  attr_reader :name

  def initialize(name)
    @name = name
    @known_cards = {}
    @matched_cards = []
    @next_guess = nil
  end

  def prompt
  end

  def get_input
    result = nil
    if @next_guess.nil?
      result = get_random_pos
    else
      result = @next_guess.dup
      @next_guess = nil
    end

    result
  end

  def get_random_pos
    random = [rand(0...@size),rand(0...@size)]
    while @known_cards.key?(random)
      random = [rand(0...@size),rand(0...@size)]
    end
    random
  end

  def check_match(pos, value)
    @known_cards.each do |k , v|
      return k if v == value && k != pos
    end
    false
  end

  def receive_revealed_card(pos, val)
    @next_guess = check_match(pos, val) if check_match(pos, val)
    @known_cards[pos] = val
  end

  def receive_match(pos_one, pos_two)
    @matched_cards << pos_one
    @matched_cards << pos_two
    @next_guess = nil
  end

  def set_board_size(size)
    @size = size
  end


end
