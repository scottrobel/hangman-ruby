require "./lib/players"
require './lib/game'
require './lib/file_manager.rb'
game = FileManager.get_game
until(game.game_over?)
    game.play_round
    FileManager.save_game(game) if(game.save_game?)
end
