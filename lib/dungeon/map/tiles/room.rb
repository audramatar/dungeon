require_relative './tile.rb'

# Creates a class specific to 'room' tiles
class Room < Tile
  def initialize(grid_point, encounter_details, up = false)
    super(grid_point, encounter_details, up)
    @type = 'room'
    @icon = 'r '
    @size = [8, 8]
  end
end
