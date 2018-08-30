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
    super
    @map = {}
    @location = nil
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

  def draw_map
    x_max = @map.keys.max_by { |x| x[0] }[0]
    y_max = @map.keys.max_by { |y| y[1] }[1]
    x_min = @map.keys.min_by { |x| x[0] }[0]
    y_min = @map.keys.min_by { |y| y[1] }[1]

    (y_min..y_max).reverse_each do |y|
      (x_min..x_max).each do |x|
        if @map[[x, y]].nil?
          print_icon(' ')
        elsif @map[[x, y]] == 'wall'
          print_icon('.')
        elsif @location.grid_point == [x, y]
          print_icon('C')
        else
          print_icon(@map[[x, y]].icon)
        end
      end
      new_line(2)
    end
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
