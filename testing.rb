require 'require_all'
require 'byebug'
require_relative './lib/dungeon/dungeon.rb'
require_relative './lib/assets/game_script.rb'

GameScript.write_to_script
puts GameScript.script[:text]