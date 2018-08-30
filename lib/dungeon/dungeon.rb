require_relative '../file_helper.rb'
require_relative './map/map_factory.rb'

class Dungeon
  attr_reader :maps

  def initialize(min_rooms)
    @maps = { 1 => MapFactory.create_map(min_rooms, 1) }
  end

  def add_level(min_rooms)
    new_level = @maps.keys.last + 1
    @maps[new_level] = MapFactory.create_map(min_rooms, new_level)
  end
end
