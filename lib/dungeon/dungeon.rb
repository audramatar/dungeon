require 'byebug'
require_relative '../map/map_factory.rb'

class Dungeon
  attr_reader :dungeon

  def initialize(min_rooms)
    @dungeon = { 1 => MapFactory.create_map(1, min_rooms) }
  end

  def get_upper_lower_bounds(map)
    keys = map.keys
    left = keys.collect { |ind| ind[0] }
    right = keys.collect { |ind| ind[1] }
    [left.min, left.max, right.min, right.max]
  end

  def print_map(level, map)
    bounds = get_upper_lower_bounds(map)
    x_low_bound = bounds[0]
    x_up_bound = bounds[1]
    y_low_bound = bounds[2]
    y_up_bound = bounds[3]

    (x_low_bound..x_up_bound).each do |x|
      (y_low_bound..y_up_bound).each do |y|
        point_on_map = map[[x, y]]
        if point_on_map.nil?
          print '. '
        elsif point_on_map.down
          print 'D '
        elsif point_on_map.up
          if level == 1
            print 'S '
          else
            print 'U '
          end
        elsif point_on_map.type == 'hall'
          print 'h '
        elsif point_on_map.type == 'room'
          print 'r '
        end
      end
      print "\n"
    end
  end
end
