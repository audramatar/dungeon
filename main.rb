require_relative 'lib/map/map_builder.rb'

map = MapBuilder.new(7)
map.print_map
map.print_connections([0, 0])