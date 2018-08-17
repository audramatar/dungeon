# A tile is a space that a player can reach within a map. This is a parent class for
# hall and room.
class Tile
  attr_reader :type, :is_start, :grid_point, :encounter
  attr_accessor :connections, :directions

  def initialize(grid_point, is_start = false)
    @grid_point = grid_point
    @connections = {}
    @directions = {}
    @encounter = nil
    @is_start = is_start
  end

  def print_valid_directions(previous)
    @directions.each do |direction, point|
      if point == previous
        puts direction.ljust(10) + ' => '.ljust(10) + @connections[point].type + ' (back the way you came)'
      elsif @connections[point].is_start
        puts direction.ljust(10) + ' => '.ljust(10) + 'back to start'
      else
        puts direction.ljust(10) + ' => '.ljust(10) + @connections[point].type
      end
    end
  end

  def set_encounter
    @encounter = "This #{@type} has an encounter!"
  end
end
