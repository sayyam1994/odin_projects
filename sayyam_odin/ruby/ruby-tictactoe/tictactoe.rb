class Board
    attr_reader :cells

    def initialize
        @cells = Array.new(9," ")
    end

    def draw_board
        puts " "
        (0..8).step(3) do |i|
            puts " #{@cells[i]} | #{@cells[i+1]} | #{@cells[i+2]} "
        end 
    end

    def board_instructions
        puts "Choose your position by typing from 1 to 9 as shown in figure"
        puts " 1 | 2 | 3 "
        puts " 4 | 5 | 6 "
        puts " 7 | 8 | 9 "
    end

    def put_symbol(player,position,symbol)
        @cells[position-1] = symbol
        draw_board
    end

    def cell_taken?(position)
        @cells[position-1] == "X" || @cells[position-1] == "O"
    end
end

class Player
    attr_accessor :name
    def initialize(name)
        @name = name
    end
end

class TicTacToe
    attr_accessor :player1, :player2

    def initialize
        welcome
        choose_symbol
        greetings
        game_start
        game_loop
    end

    def welcome
        puts "Welcome to command line TicTacToe"
        puts "---------------------------------"
        puts "Enter Player 1's name"
        @player1 = Player.new(gets.chomp.capitalize)
        puts ""
        puts "Enter Player 2's name"
        @player2 = Player.new(gets.chomp.capitalize)
        puts ""
    end

    def choose_symbol
        
        loop do
            puts "#{@player1.name}, choose your symbol, X/O"
            @player1_symbol = gets.chomp.upcase
            break if @player1_symbol == "X" || @player1_symbol == "O"
        end

        if @player1_symbol == "X"
            @player2_symbol = "O"
        else
            @player2_symbol = "X"
        end
    end

    def greetings
        puts ""
        puts "#{@player1.name} has choosen :- #{@player1_symbol}"
        puts "#{@player2.name} gets :- #{@player2_symbol}"
        puts "--------------------------------------------"
        puts "Now let the game begins"
        puts ""
    end

    def game_start
        board = Board.new
        player1 = @player1
        player1_symbol = @player1_symbol
        player2 = @player2
        player2_symbol = @player2_symbol
        Game.new(player1,player2,player1_symbol,player2_symbol,board)
    end

    def play_again
        puts "Do you want to play the game again, Y/N"
        loop do
            input = gets.chomp.upcase
            return true if input == "Y"
            return false if input == "N"
            puts "Enter the correct choice"
        end
    end

    def game_loop
        game_start while play_again
    end
end

class Game

    def initialize(player1,player2,player1_symbol,player2_symbol,board)
        @player1 = player1
        @player2 = player2
        @player1_symbol = player1_symbol
        @player2_symbol = player2_symbol
        @board = board
        @current_player = player1
        @turn_number = 1
        turn(@current_player)
    end

    def turn(player)
        puts "Current Turn:- #{@turn_number}"
        puts "#{player.name}, Make your choice"
        @board.board_instructions
        puts ""
        loop do
            choice = get_position
            symbol = check_player(player)
            if @board.cell_taken?(choice) == false
                @board.put_symbol(player,choice,symbol) 
                check_winner(@current_player)
                next_turn(@current_player)
                break
            else
                puts "Sorry! the cell is occupied, please select another cell"
            end
        end
    end

    def check_player(player)
        if player == @player1
            return @player1_symbol
        else
            return @player2_symbol
        end
    end

    def get_position
        loop do
            choice = gets.chomp
            if choice.to_i > 0 && choice.to_i < 10
                return choice.to_i
                break
            else
                puts "Please make a valid choice between 1-9"
            end
        end
    end

    def next_turn(player)
        @turn_number += 1
        if (@turn_number>9 && check_winner(player) == false)
            puts "Draw!!!"
        elsif check_winner(player) == true
            puts "#{player.name} is the Winner!!!!"
        else
            if @current_player == @player1
                @current_player = @player2
                turn(@current_player)
            else
                @current_player = @player1
                turn(@current_player)
            end
        end
    end

    def check_winner(player)
        combination = Array.new
        winning_combintaions = [
                                [1,2,3],
                                [4,5,6],
                                [7,8,9],
                                [1,5,9],
                                [3,5,7],
                                [1,4,7],
                                [2,5,8],
                                [3,6,9]
                            ]
        symbol = check_player(player)
        for i in 0..8 do
            if @board.cells[i] == symbol
                combination <<(i + 1)
            end
        end
        
        for i in 0..7 do 
            if winning_combintaions[i].all?{ |y| combination.include?(y) }
                return true
            end
        end
        false
    end


end


TicTacToe.new
