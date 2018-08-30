require_relative '../../file_helper.rb'
require_rel './tiles'

# Map Builder creates a randomized map.
class MapFactory

  # Change map to 'tiles' and add in attributes:
  # map bounds stairs_up, level, stairs_down
  # potentially fill out map to have dead points?

  def self.create_map(min_rooms, level=1)
    @min_rooms = min_rooms
    @level = level
    @stairs_down = false
    @tiles_rooms = 0
    @opposite_direction = { 'north' => 'south', 'south' => 'north',
                            'east' => 'west', 'west' => 'east' }
    @starting_point = Room.new([0, 0], true)
    @x_low_bound = 0
    @x_up_bound = 0
    @y_low_bound = 0
    @y_up_bound = 0
    @tiles = { [0, 0] => @starting_point }
    create_path(@starting_point.grid_point)
    @map = { tiles: @tiles, stairs_up: [0, 0], stairs_down: @stairs_down, level: @level,
             x_low_bound: @x_low_bound, x_up_bound: @x_up_bound, y_low_bound: @y_low_bound,
             y_up_bound: @y_up_bound }
    @map
  end

  def self.create_path(grid_point)
    directions = get_directions(grid_point)

    set_new_point(directions, grid_point) if @tiles_rooms < @min_rooms
  end

  def self.get_directions(grid_point)
    { 'east' => [grid_point[0] + 1, grid_point[1]],
      'west' => [grid_point[0] - 1, grid_point[1]],
      'north' => [grid_point[0], grid_point[1] + 1],
      'south' => [grid_point[0], grid_point[1] - 1] }
  end

  def self.set_new_point(directions, current_point)
    directions.each_pair do |direction, point|
      if @tiles[point]
        connect_points(point, current_point, direction) unless @tiles[current_point].connections[point]
      else
        unless @tiles_rooms >= @min_rooms
          if [true, false].sample
            create_new_tile(direction, point, current_point)
            update_bounds(point[0], point[1])
            create_path(point)
          end
        end
      end
    end
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
      @tiles[point] = Room.new(point)
      @tiles_rooms += 1
    else
      @tiles[point] = Hall.new(point)
    end
    connect_points(point, current_point, direction)
    encounter_selection(point)

    @stairs_down = point if @tiles[point].encounter == 'stairs down'
  end

  def self.encounter_selection(point)
    last_room = @tiles_rooms == @min_rooms
    if last_room && !@stairs_down
      @tiles[point].set_encounter(@level, @stairs_down, last_room)
    elsif [true, false, false].sample
      @tiles[point].set_encounter(@level, @stairs_down, last_room)
    end
  end

  def self.connect_points(point, current_point, direction)
    @tiles[point].connections[current_point] = @tiles[current_point]
    @tiles[current_point].connections[point] = @tiles[point]
    @tiles[point].directions[@opposite_direction[direction]] = current_point
    @tiles[current_point].directions[direction[direction]] = point
  end
end
