require_relative "players"
require 'colorize'
class Game
    attr_reader :player_name
    def initialize(player)
        @player_name = player.name
        @guesses_left = 10
        @bad_guesses = []
        @correct_guesses = {}
        set_secret_word
    end
    def make_guess(char)
        if(!game_over?)
            @guesses_left -= 1
            if(secret_word.include?(char))
                update_correct_chars(char)
                puts "correct"
            else
                update_incorrect_chars(char)
                puts "incorrect"
            end
            puts "you win" if(win?)
        else
            puts "game over".red
        end
    end
    def display_hints
        puts "#{get_hints}".green
    end
    def display_bad_guesses
        puts "Wrong chars [#{@bad_guesses.join(" ")}]".red
    end
    def game_over?
        win? || loss?
    end
    def get_user_input
        puts "enter char"
        input = gets.chomp
        if(input.match?(/[a-z]/))
            input = input.scan(/[a-z]/)[0]
        else
            get_user_input
        end
        input
    end
    def to_s
        "#{@player_name}'s game #{get_hints} wrong letters#{@bad_guesses}"
    end
    private
    def get_hints
        hints = ("_" * secret_word.length).chars
        @correct_guesses.each do |index, char|
            hints[index] = char
        end
        hints.join(" ")
    end
    def win?
        secret_word == get_hints
    end
    def loss?
        @guesses_left == 0 && !win?
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
    end
    def secret_word
        @secret_word
    end
end