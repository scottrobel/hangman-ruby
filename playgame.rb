require "./lib/players"
require './lib/game'
$saved_games = File.open("saved_games.txt","w+")
def save_game(game)
    $saved_games.write(Marshal.dump(game))
    $saved_games.write(Marshal.dump("_____"))
end
def get_saved_games
    $saved_games.rewind
    games = $saved_games.read.split("_____").map{|game| Marshal.load(game)}
end
1000.times do |i|
    save_game(Game.new(Player.new("#{i}")))
end
re_opened_game = get_saved_games[5]
re_opened_game.make_guess("f")
re_opened_game.display_hints
re_opened_game.display_bad_guesses
