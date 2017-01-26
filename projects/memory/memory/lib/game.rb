require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'
require 'byebug'
class Game
  attr_reader :board
  def initialize(player = ComputerPlayer.new("john"))
    @board = Board.new
    @previous_guess = nil
    @player = player
    @player.set_board_size(@board.size)
  end

  def play

    play_turn until game_over?
    puts "You Win!"
  end

  def play_turn
    render
    #debugger
    @guessed_pos = get_guess
    make_guess
    render
    @guessed_pos = get_guess
    make_guess
  end

  def render
    system("clear")
    @board.render
  end

  def make_guess
    reveal_card(@guessed_pos)
    @player.receive_revealed_card(@guessed_pos, @board[@guessed_pos].value)
    if @previous_guess.nil?
      @previous_guess = @guessed_pos
    else
      render
      if match?(@previous_guess, @guessed_pos)
        @player.receive_match(@previous_guess, @guessed_pos)
        puts "You got a match!"
      else
        hide_cards
        puts "No match :("
      end
      sleep(2)
      @previous_guess = nil
    end
  end

  def hide_cards
    @board.hide(@previous_guess)
    @board.hide(@guessed_pos)
  end

  def match?(pos_one, pos_two)
    @board.match_cards?(pos_one, pos_two)
  end

  def get_guess
    @player.prompt
    guess = @player.get_input
    until valid_guess?(guess)
      puts "Invalid guess, try again"
      guess = @player.get_input
    end
    guess
  end

  def valid_guess?(guess)
    @board.card_revealed?(guess) ? false : true
  end

  def reveal_card(position)
    @board.reveal(position)
  end

  def game_over?
    @board.won?
  end

end
