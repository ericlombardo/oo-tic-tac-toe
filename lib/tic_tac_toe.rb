require 'pry'

class TicTacToe
  
  def initialize  # create new board for each object
    @board = Array.new(9, " ")
  end
  WIN_COMBINATIONS = [    # list out the possible winning combos
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]
  def display_board   # insert @board array and display board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)  # change from 1-9 to 0-8 for zero index
    user_input.to_i - 1
  end

  def move(user_input, player = "X")  # insert player marker into array
    @board[user_input] = player
  end
  
  def position_taken?(position)   # check if position is available
    @board[position] == "X" || @board[position] == "O" ? true : false
  end
  
  def valid_move?(position)   # make sure position is available and between 0-8
    (0..8).include?(position) && !position_taken?(position)
  end
  def turn_count  # keep track of number of turns
    @board.count {|spot| spot != " "}
  end
  def current_player  # allows us to know if marker is 'X' or 'O'
    turn_count % 2 == 0 ? 'X' : 'O'
  end
  def turn  # prompts for input, changes to 0-index, verify valid move, make move, display board
    puts 'Please put you position in: 1 - 9'
    input = gets.chomp
    input = input_to_index(input)
    valid_move?(input) ? move(input, current_player) && display_board : turn
  end
  def won?  # loops through win_combinations for all 'X' or all 'O', returns array if ther's a win
    winner = WIN_COMBINATIONS.select do |arrays|
      arrays.all?{|item| @board[item] == "X"} || arrays.all?{|item| @board[item] == "O"}
    end
    winner.empty? ? false : winner.flatten
  end

  def full? # checks if board is full and no wins
    true if !won? && turn_count == 9
  end

  def draw? # check if full and no win
    true if full? && !won?
  end

  def over? # check for draw? or a win?
    true if draw? || won?
  end

  def winner  # displays the winner
    current_player == "X" ? 'O' : 'X' if won?
  end

  def play  # logic for the game, run turn and check each time it over, when over display congrats or cats' message
    until over?
      turn
    end
    puts "Congratulations #{winner}!" if won?
    puts "Cat's Game!" if draw?
  end

end