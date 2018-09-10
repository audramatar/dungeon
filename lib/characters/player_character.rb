require_relative '../file_helper.rb'
require_relative './character.rb'
require_relative '../UI/player_character_ui.rb'
require_relative '../UI/basic_ui.rb'

# Class for any player characters.
class PlayerCharacter < Character
  include PlayerCharacterUI
  include BasicUI

  attr_reader :map, :location
  def initialize
    @map = {}
    @location = nil
    super
  end

  def get_on_map(starting_point, starting_tile)
    @location = starting_tile
    @map[starting_point] = starting_tile
    update_character_map(starting_tile)
  end

  def move_on_map(tile)
    @location = tile
    update_character_map(tile)
  end

  private

  def update_character_map(tile)
    directions = get_directions(tile)

    directions.each do |direction|
      @map[direction] = if tile.connections[direction].nil?
                          'wall'
                        else
                          tile.connections[direction]
                        end
    end
  end

  def get_directions(tile)
    east = [tile.grid_point[0] + 1, tile.grid_point[1]]
    west = [tile.grid_point[0] - 1, tile.grid_point[1]]
    north = [tile.grid_point[0], tile.grid_point[1] + 1]
    south = [tile.grid_point[0], tile.grid_point[1] - 1]

    [north, south, east, west]
  end
end
