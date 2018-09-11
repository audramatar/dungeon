require_relative './tile.rb'

# Creates a class specific to 'hall' tiles.
class Hall < Tile
  def initialize(grid_point, encounter_details, up = false)
    @type = 'hall'
    @icon = 'h '
    @size = [4, 6]
    super(grid_point, encounter_details, up)
  end
end
