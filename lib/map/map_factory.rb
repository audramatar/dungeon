require 'byebug'
require 'require_all'
require_rel './tiles'

# Map Builder creates a randomized map.
class MapFactory
  attr_reader :map

  def self.create_map(level, min_rooms)
    @min_rooms = min_rooms
    @level = level
    @stairs_set = false
    @map_rooms = 0
    @opposite_direction = { 'north' => 'south', 'south' => 'north',
                            'east' => 'west', 'west' => 'east' }
    @starting_point = Hall.new([0, 0], true)
    @x_low_bound = 0
    @x_up_bound = 0
    @y_low_bound = 0
    @y_up_bound = 0
    @map = { [0, 0] => @starting_point }
    create_path(@starting_point.grid_point)
    @map
  end

  def self.print_connections
    @map[[0, 0]].print_valid_directions
  end

  def self.create_path(grid_point)
    directions = get_directions(grid_point)
    paths = 0

    paths = set_new_point(directions, grid_point) while paths.zero? && @map_rooms < @min_rooms
  end

  def self.get_directions(grid_point)
    { 'north' => [grid_point[0] + 1, grid_point[1]],
      'south' => [grid_point[0] - 1, grid_point[1]],
      'east' => [grid_point[0], grid_point[1] + 1],
      'west' => [grid_point[0], grid_point[1] - 1] }
  end

  def self.set_new_point(directions, current_point)
    paths = 0
    directions.each_pair do |direction, point|
      if @map[point]
        connect_points(point, current_point, direction) unless @map[current_point].connections[point]
      else
        unless @map_rooms >= @min_rooms
          if [true, false].sample
            create_new_tile(direction, point, current_point)
            paths += 1
            update_bounds(point[0], point[1])
            create_path(point)
          end
        end
      end
    end
    paths
  end

  def self.update_bounds(x, y)
    if x > @x_up_bound
      @x_up_bound = x
    elsif x < @x_low_bound
      @x_low_bound = x
    end

    if y > @y_up_bound
      @y_up_bound = y
    elsif y < @y_low_bound
      @y_low_bound = y
    end
  end

  def self.create_new_tile(direction, point, current_point)
    room = [true, false, false].sample
    if room
      @map[point] = Room.new(point)
      @map_rooms += 1
    else
      @map[point] = Hall.new(point)
    end
    connect_points(point, current_point, direction)
    last_room = @map_rooms == @min_rooms
    if last_room && !@stairs_set
      @map[point].set_encounter(@level, @stairs_set, last_room)
    else
      @map[point].set_encounter(@level, @stairs_set, last_room) if [true, false, false].sample
    end

    @stairs_set = true if @map[point].encounter == 'stairs down'
  end

  def self.connect_points(point, current_point, direction)
    @map[point].connections[current_point] = @map[current_point]
    @map[current_point].connections[point] = @map[point]
    @map[point].directions[direction] = current_point
    @map[current_point].directions[@opposite_direction[direction]] = point
  end
end
