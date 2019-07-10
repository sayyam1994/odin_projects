require "json"

class Dictionary
    def initialize
        @file = File.readlines "dictionary.txt"
    end

    def secret_word_generator
        loop do 
            secret_word = @file[rand(@file.length)].gsub("\n", "")
            return secret_word.downcase if (secret_word.length > 4 && secret_word.length < 13)
        end
    end
end

class Game
    def initialize
        @secret_word = Dictionary.new
        @turns = 12
        @hidden_word_array = Array.new
        @incorrect_letter = Array.new
        game_options
    end

    def game_options
        input = nil
        loop do
            puts "Would you like to start a new game or load a previous save?"
            puts "1. New Game || 2. Load Game"
            print "Please select 1 or 2: "
            input = gets.chomp
            break if input == "1" || input == "2"
        end

        input == "1"? new_game : load_game
    end

    def new_game
        instructions
        hidden_word_generator
        dash_printer
        check_player_input
    end

    def resume_game
        instructions
        print "Secret Word: "
        print @hidden_word_array.join
        puts ""
        check_player_input
    end

    def instructions
        puts "***************************************"
        puts "**** Welcome To The Hangman Game! *****"
        puts "***************************************"
        puts "======================================="
        puts "************ Instructions *************"
        puts "***************************************"
        puts "1. The objective of the game is to guess"
        puts "letters to a secret word. The secret word"
        puts "is represented by a series of horizontal"
        puts "lines indicating its length. "
        puts "For example:"
        puts "If the secret word it 'chess', then it will "
        puts "be displayed as:"
        puts "_ _ _ _ _ \n "
        puts "2. You are given 12 chances. For each incorrect"
        puts "guess, the chances will decrease by 1. For each correct"
        puts "guess, the part of the secret word are revealed"
        puts "For example: If your guess is 's' then the result"
        puts "of the guess will be:"
        puts "_ _ _ s s \n "
        puts "3. When you guessed all the correct letters to the secret word"
        puts "or when you are out of chances, it will be game over."
        puts ""
        puts "4. Any time during the game, if you would like to save"
        puts "your progress, type 'save--' without the quotes"
        puts ""
        puts ""
    end

    def hidden_word_generator
        @hidden_word = @secret_word.secret_word_generator
    end

    def dash_printer
        print "Secret Word: "
        for i in 0..@hidden_word.length-1 do
            @hidden_word_array[i] = "_ "    
        end
        print @hidden_word_array.join
        puts ""
    end

    def get_player_guess
        loop do
            puts ""
            print "Please enter your guess:  "
            player_guess = gets.chomp.downcase
            if player_guess == "save--"
                save_game
                exit
            else
                if player_guess.length != 1
                    puts "Please enter single letter only"
                else
                    if (player_guess =~ /[a-z]/)
                        return player_guess
                        break
                    else
                        puts "Please enter alphabets only"
                    end
                end
            end
        end
    end

    def check_player_input
        puts ""
        puts "Turn Number:  #{@turns}"
        puts ""
        player_guess = get_player_guess
        i = 0
        @hidden_word.split("").each do |x|
            if player_guess == x
                @hidden_word_array[i] = x 
            end
            i += 1
        end
        if !@hidden_word.include?player_guess 
            @incorrect_letter << player_guess  if !@incorrect_letter.include?player_guess 
        end
        print @hidden_word_array.join
        puts ""
        print "Incorrect Letters: #{@incorrect_letter}"
        check_winner
    end

    def turn_decreaser
        @turns -= 1
    end

    def check_winner
        if @hidden_word_array.join == @hidden_word
            puts ""
            puts "You have won the game"
        else
            turn_decreaser
            if @turns == 0
            puts ""
            puts "Sorry, you lost the game"
            puts ""
            puts "The correct answer is #{@hidden_word}"
            else
                check_player_input
            end
        end
    end

    def save_game
        game_data = {
            turns: @turns,
            secret_word: @hidden_word,
            incorrect_letter: @incorrect_letter,
            hidden_word_array: @hidden_word_array
        }

        Dir.mkdir("saves") unless Dir.exists? "saves"

        puts ""
        puts "WARNING! If the filename already exist the data on that file will be overwritten!"
        puts "Enter a filename for your save: "
        filename = gets.chomp

        File.open("saves/#{filename}.json","w") do |f|
            f.write(game_data.to_json)
        end
        puts "Game progress has been saved"
    end

    def load_game
       filename = nil
       loop do
            puts "Please enter the saved file name"
            filename = gets.chomp
            break if File.exist?"saves/#{filename}.json"
            puts "File does not exist"
       end

       game_data = JSON.parse(File.read("saves/#{filename}.json"), :symbolize_names => true)

       @turns = game_data[:turns]
       @hidden_word = game_data[:secret_word]
       @hidden_word_array = game_data[:hidden_word_array]
       @incorrect_letter = game_data[:incorrect_letter]
       resume_game
    end

end

Game.new