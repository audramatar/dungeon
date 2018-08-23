# A tile is a space that a player can reach within a map. This is a parent class for
# hall and room.
class Tile
  attr_reader :type, :is_start, :grid_point, :encounter, :down, :up
  attr_accessor :connections, :directions

  def initialize(grid_point, up = false)
    @grid_point = grid_point
    @connections = {}
    @directions = {}
    @encounter = nil
    @down = false
    @up = up
  end

  def print_valid_directions(previous)
    @directions.each do |direction, point|
      if point == previous
        puts direction.ljust(10) + ' => '.ljust(10) + @connections[point].type + ' (back the way you came)'
      elsif @connections[point].up
        puts direction.ljust(10) + ' => '.ljust(10) + 'back to start'
      else
        puts direction.ljust(10) + ' => '.ljust(10) + @connections[point].type
      end
    end
  end

  def set_encounter(level, stairs_set, last_room)
    encounters = ['monster attack', 'boss monster', 'miniboss monster', 'trap', 'puzzle',
                  'distressed humanoid: trap', 'distressed humanoid: ally', 'treasure chest', 'mimic']
    encounters.push('stairs down') if @type == 'room' && !stairs_set

    @encounter = last_room && !stairs_set ? 'stairs down' : encounters.sample

    @down = true if @encounter == 'stairs down'
  end
end
