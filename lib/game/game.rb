require 'require_all'
require 'json'
require 'byebug'
require_rel '../characters'
require_relative '../dungeon/dungeon.rb'

class Game
  def start_game
    create_character
    enter_map
  end

  def create_character
    @pc = PlayerCharacter.new
  end

  def enter_map
    @dungeon = Dungeon.new(5)
    @map = @dungeon.maps[1]
    starting_point = @map[:stairs_up]
    starting_tile = @map[:tiles][starting_point]
    @pc.get_on_map(starting_point, starting_tile)
    @pc.draw_map
  end

  def turn
    puts "Which way do you want to go?"
    print "> "
    direction = gets.chomp
    new_location = @pc.location.directions[direction]
    if new_location.nil?
      puts "That's not a valid direction! Try again!"
    else
      @pc.move_on_map(new_location, @map[:tiles][new_location])
      @pc.draw_map
    end
  end
end

game = Game.new
game.start_game
while true
  game.turn
end