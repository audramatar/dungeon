require_relative 'lib/game/game.rb'

game = Game.new

game.start_game
game.turn while true
