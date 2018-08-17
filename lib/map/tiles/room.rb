require_relative '../tile.rb'

# Creates a class specific to 'room' tiles
class Room < Tile
  def initialize(grid_point, is_start = false)
    @type = 'room'
    super(grid_point, is_start)
  end
end
