require_relative './tile.rb'

# Creates a class specific to 'room' tiles
class Room < Tile
  def initialize(grid_point, encounter_details, up = false)
    @type = 'room'
    @icon = 'r '
    super(grid_point, encounter_details, up)
  end
end
