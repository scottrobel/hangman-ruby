$saved_games = File.open("./saved_games.txt","r+")
class FileManager
    def self.create_valid_words_file
        text_file = File.open("../words/5desk.txt")
        if(!File.exist?("../words/valid_words.txt"))
            valid_words = File.open("../words/valid_words.txt", "w+")
            while !text_file.eof?
                word = text_file.readline
                word_length = word.chomp.length
                valid_words.write(word) if(word_length <= 12 && word_length >= 5)
            end
            puts "file created"
        end
    end
    def self.get_saved_game(game_number)
        saved_game = FileManager.get_saved_games[game_number]
        saved_game.game_saved = false
        saved_game
    end
    def self.get_saved_game_from_user_input
        largest_game_number = FileManager.get_saved_games[-1].game_number
        game_number = -1
        while(!(0 <= game_number && game_number <= largest_game_number))
            puts "what game number would you like to resume"
            matches = gets.chomp.match(/[0-9]/)
            game_number = (matches)? matches[0].to_i : "-1"
        end
        FileManager.get_saved_game(game_number)
    end
    def self.get_game
        if(!FileManager.get_saved_games.empty?)
            game = nil
            while(game == nil)
                display_saved_games
                puts "would you like to resume one of these games\ny/yes = resume saved game\nn/no = create new game"
                answer = gets.chomp.downcase
                game = FileManager.get_saved_game_from_user_input if(answer == "y" || answer == "yes")
                game = FileManager.make_game_from_user_input if(answer == "n" || answer == "no")
            end
        else
            game = FileManager.make_game_from_user_input
        end
        puts game
        game
    end
    def self.make_game_from_user_input
        puts "creating new game".green
        puts "enter your name"
        name = gets.chomp
        Game.new(Player.new(name))
    end
    def self.save_game(game)
        largest_game_number = FileManager.get_saved_games[-1].game_number
        if(!game.game_number)
            game.game_saved = true
            games = FileManager.get_saved_games
            game.game_number = (largest_game_number)? largest_game_number +1 : 0
            games << game
            marshaled_games = games.map{|game| Marshal.dump(game)}
            $saved_games = File.open("./saved_games.txt","w+")
            $saved_games.write(marshaled_games.join("_____"))
            puts "file was saved"
        else
            games = FileManager.get_saved_games
            games[game.game_number] = game
            marshaled_games = games.map{|game| Marshal.dump(game)}
            $saved_games = File.open("./saved_games.txt","w+")
            $saved_games.write(marshaled_games.join("_____"))
            puts "file was resaved"
        end
    end
    def self.display_saved_games
        puts FileManager.get_saved_games
    end
    def self.get_saved_games
        $saved_games.rewind
        $saved_games.read.split("_____").map{|game| Marshal.load(game)}
    end
end 