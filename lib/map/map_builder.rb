require_relative 'tile.rb'

# Map Builder creates a randomized map.
class MapBuilder
  attr_reader :map

  def initialize(min_rooms)
    @min_rooms = min_rooms
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
  end

  def print_connections
    @map[[0, 0]].print_valid_directions
  end

  def print_map
    (@x_low_bound..@x_up_bound).each do |x|
      (@y_low_bound..@y_up_bound).each do |y|
        point_on_map = @map[[x, y]]
        if point_on_map.nil?
          print '. '
        elsif point_on_map.is_start
          print 'S '
        elsif point_on_map.type == 'hall'
          print 'h '
        elsif point_on_map.type == 'room'
          print 'r '
        end
      end
      print "\n"
    end
  end

  def create_path(grid_point)
    directions = get_directions(grid_point)
    paths = 0

    paths = set_new_point(directions, grid_point) while paths.zero? && @map_rooms < @min_rooms
  end

  def get_directions(grid_point)
    { 'north' => [grid_point[0] + 1, grid_point[1]],
      'south' => [grid_point[0] - 1, grid_point[1]],
      'east' => [grid_point[0], grid_point[1] + 1],
      'west' => [grid_point[0], grid_point[1] - 1] }
  end

  def set_new_point(directions, current_point)
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

  def update_bounds(x, y)
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

  def create_new_tile(direction, point, current_point)
    room = [true, false, false].sample
    if room
      @map[point] = Room.new(point)
      @map_rooms += 1
    else
      @map[point] = Hall.new(point)
    end
    connect_points(point, current_point, direction)

    @map[point].set_encounter if [true, false, false].sample
  end

  def connect_points(point, current_point, direction)
    @map[point].connections[current_point] = @map[current_point]
    @map[current_point].connections[point] = @map[point]
    @map[point].directions[direction] = current_point
    @map[current_point].directions[@opposite_direction[direction]] = point
  end
end
