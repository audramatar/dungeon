require_relative '../tile.rb'

# Creates a class specific to 'hall' tiles.
class Hall < Tile
  def initialize(grid_point, is_start = false)
    @type = 'hall'
    @icon = 'h '
    super(grid_point, is_start)
  end
end
