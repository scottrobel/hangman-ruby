require_relative "players"
require 'colorize'
class Game
    attr_reader :player_name
    attr_accessor :game_number, :game_saved
    def initialize(player)
        @player_name = player.name
        @guesses_left = 10
        @bad_guesses = []
        @correct_guesses = {}
        @game_saved = false
        set_secret_word
    end
    def play_round
        display_bad_guesses
        display_hints
        display_guesses_left
        guess = get_user_input
        make_guess(guess)
    end
    def display_guesses_left
        puts "you have #{@guesses_left}. use them wisley"
    end
    def save_game?
        puts "Press enter to continue the game or type 'save' (no quotes)to save the game and continue it later"
        user_input = gets.chomp.downcase
        (user_input == "save")? true : false
    end
    def make_guess(char)
        @guesses_left -= 1
        if(secret_word.include?(char))
            update_correct_chars(char)
            puts "correct"
        else
            update_incorrect_chars(char)
            puts "incorrect"
        end
        puts "you win" if(win?)
    end
    def display_hints
        puts "#{get_hints}".green
    end
    
    def game_over?
        win? || loss? || game_saved?
    end
    def get_user_input
        puts "enter char"
        guess = gets.chomp.downcase
        while(!guess.match(/[a-z]/))
            puts "invalid char please try again"
            guess = gets.chomp.downcase
        end
        guess.match(/[a-z]/)[0]
    end
    def to_s
        "game ##{game_number} #{@player_name} #{get_hints} wrong letters#{@bad_guesses}"
    end
    def game_saved?
        @game_saved
    end
    private
    def display_bad_guesses
        puts "Wrong chars [#{@bad_guesses.join(" ")}]".red
    end
    def get_hints
        hints = ("_" * secret_word.length).chars
        @correct_guesses.each do |index, char|
            hints[index] = char
        end
        hints.join(" ")
    end
    def win?
        if(secret_word == get_hints)
            puts "congrads! you win!"
            return true
        else
            false
        end
    end
    def loss?
        if(@guesses_left == 0 && !win?)
            puts "You loose!"
            return true
        else
            return false
        end
    end
    def update_correct_chars(char)
        secret_word.chars.each_with_index do |secret_letter,index|
            if(secret_letter == char)
                @correct_guesses[index] = char
            end
        end
    end
    def update_incorrect_chars(char)
        @bad_guesses << char
    end
    def set_secret_word
        valid_words = File.open("./words/valid_words.txt", "r")
        valid_words.rewind
        random_line = rand(52454)
        random_line.times{valid_words.readline}#will read between 0 and 52453 lines
        @secret_word = valid_words.readline.chomp
        print "secret word set"
    end
    def secret_word
        @secret_word
    end
end