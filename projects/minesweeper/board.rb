class Board

  DIFFICULTY_SIZE = {
    easy: 9,
    medium: 15,
    hard: 30
  }

  DIFFICULTY_BOMBS = {
    easy: 10,
    medium: 30,
    hard: 40
  }

  def self.intialize_from_user
    print "Select a difficulty level (easy, medium, hard): "
    valid_entry(gets.chomp) #check if is valid entry
    # keep asking until we get a valid one
    #repeat the same thing with the amount of bombs
    # create a grid: empty 2-d array with size DIFFICULTY[entry]
    #

    # Initialize board Board.new(grid)

  end

  def initialize(grid, num_bombs)
    # grid is going to be empty 2-d array at first
    # populate grid with blank tiles (populate_grid)
    # set the bombs (set_bombs_randomly)
  end

  def valid_entry(difficulty)

  end

  def populate_grid
    # Populate the grid with blank tiles
  end

  def set_bombs_randomly(num_bombs)

  end

  def game_over
    # reveal a bomb or all blank values are revealed
  end



end
