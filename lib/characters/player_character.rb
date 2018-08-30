require_relative '../file_helper.rb'
require_relative './character.rb'

# Class for any player characters.
class PlayerCharacter < Character
  attr_reader :map, :location
  def initialize
    super
    @map = {}
  end

  def get_on_map(starting_point, starting_tile)
    @location = starting_tile
    @map[starting_point] = starting_tile
    update_character_map(starting_tile)
  end

  def move_on_map(new_point, tile)
    @location = tile
    update_character_map(tile)
  end

  def update_character_map(tile)
    east = [tile.grid_point[0] + 1, tile.grid_point[1]]
    west = [tile.grid_point[0] - 1, tile.grid_point[1]]
    north = [tile.grid_point[0], tile.grid_point[1] + 1]
    south = [tile.grid_point[0], tile.grid_point[1] - 1]

    directions = [north, south, east, west]

    directions.each do |direction|
      if tile.connections[direction].nil?
        @map[direction] = 'wall'
      else
        @map[direction] = tile.connections[direction]
      end
    end
  end

  def draw_map
    x_max = @map.keys.max_by { |x| x[0] }[0]
    y_max = @map.keys.max_by { |y| y[1] }[1]
    x_min = @map.keys.min_by { |x| x[0] }[0]
    y_min = @map.keys.min_by { |y| y[1] }[1]

    (y_min..y_max).reverse_each do |y|
      (x_min..x_max).each do |x|
        if @map[[x, y]].nil?
          print ' '.ljust(3)
        elsif @map[[x, y]] == 'wall'
          print '.'.ljust(3)
        elsif [x, y] == @location.grid_point
          print 'C '.ljust(3)
        else
          print @map[[x, y]].icon.ljust(3)
        end
      end
      puts "\n\n"
    end
  end
end
