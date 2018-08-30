require_relative '../file_helper.rb'
require_relative '../UI/basic_ui.rb'
require_relative '../dungeon/dungeon.rb'
require_rel '../characters'

# Class to actually get the game going.
class Game
  include BasicUI

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
    direction = ask_question('Which way do you want to go?')
    new_location = @pc.location.directions[direction]
    if new_location.nil?
      print_error_message("That's not a valid direction! Please try again!")
    else
      @pc.move_on_map(@map[:tiles][new_location])
      @pc.draw_map
    end
  end
end
