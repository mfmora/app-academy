require "byebug"

class Game
  attr_reader :player1, :player2, :fragment, :dictionary, :current_player

  def initialize(player1, player2, dictionary = default_dictionary)
    @player1 = player1
    @player2 = player2
    @dictionary = dictionary
    @current_player = player1
    @fragment = ""
  end

  def display_fragment
    puts "The word so far is #{@fragment}"
  end

  def play_round
    until turn_over?
      take_turn(@current_player)
    end
    loss_adder
    turn_over_message
  end

  def run
    until game_over
      reset_game
      display_standings
      play_round
    end
  end

  def game_over_message
    puts "Game over! #{previous_player.name} lost that game!"
  end

  def reset_game
    @fragment = ""
  end

  def display_standings
    puts "#{@player1.name} has #{@player1.display_loss}"
    puts "#{@player2.name} has #{@player2.display_loss}"
  end

  def turn_over?
    @dictionary.include?(@fragment)
  end

  def next_player!
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end

  def take_turn(player)
    welcome_player
    display_fragment unless @fragment.empty?

    word = player.get_turn
    until valid_play?(word)
      alert_invalid_guess
      word = player.get_turn
    end

    @fragment << word
    next_player!
  end

  def alert_invalid_guess
    puts "The input isn't valid"
  end

  def welcome_player
    puts "Take your turn! #{@current_player.name}"
  end

  def valid_play?(string)
    letter_in_alphabet?(string) && valid_fragment?(string)
  end

  def letter_in_alphabet?(string)
    alphabet = ("a".."z").to_a

    alphabet.include?(string.downcase)
  end

  def valid_fragment?(string)
    new_fragment = @fragment + string
    @dictionary.any? do |word|
      word.scan(/^#{new_fragment}/).any?
    end
  end

  def default_dictionary
    File.readlines("dictionary.txt").map(&:chomp)
  end

  def round_over_message
    puts "Round over! #{previous_player.name} lost that round!"
  end

  def previous_player
    if @current_player == @player1
      @player2
    else
      @player1
    end
  end

  def game_over
    @player1.over? || @player2.over?
  end

  def loss_adder
    @previous_player.add_loss
  end

end

class Player

  GHOST = {
    0 => "no losses",
    1 => "G",
    2 => "GH",
    3 => "GHO",
    4 => "GHOS",
    5 => "GHOST"
  }

  attr_reader :name, :losses

  def initialize(name)
    @name = name
    @losses = 0
  end

  def get_turn
    puts "Give me a letter"
    input = gets.chomp.to_s
  end

  def add_loss
    @losses+=1
  end

  def over?
    @losses == 5
  end

  def display_loss
    GHOST[losses]
  end
end

if __FILE__ == $PROGRAM_NAME
  ghost = Game.new(Player.new("Fernanda"), Player.new("Brandon"))
  ghost.play_round


end
