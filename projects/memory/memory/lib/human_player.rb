class HumanPlayer
  attr_reader :name
  def initialize(name)
    @name = name
  end

  def prompt
    puts "Enter guess (n, m)"
  end

  def get_input
    guess = gets.chomp.split(", ").map(&:to_i)
  end

  def set_board_size(size)
    @size = size
  end

  def receive_revealed_card(pos, val)
  end

  def receive_match(pos_one, pos_two)
  end

end
