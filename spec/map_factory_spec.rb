# Things to Test -----
# Ensure that create_map returns a generated map with all the expected attributes.
# Ensure that create_map returns a map with a level that it's given.
# Ensure create_map returns a map at level 1 without a level given.
# Ensure that create_map returns a map with the number of rooms sent in.

require_relative '../lib/map/map_factory.rb'
require_relative './spec_helper.rb'

describe MapFactory do
  context 'When create_map is called' do
    num_rooms = 2
    level = 1

    it 'should return a map with all expected attributes' do
      map = MapFactory.create_map(num_rooms, level)
      expect(map[:level]).to be(1)
      expect(map[:tiles]).to be_a(Hash)
      expect(map[:stairs_up]).to be_a(Array)
      expect(map[:stairs_down]).to be_a(Array)
      expect(map[:x_low_bound]).to be_a(Integer)
      expect(map[:x_up_bound]).to be_a(Integer)
      expect(map[:y_low_bound]).to be_a(Integer)
      expect(map[:y_up_bound]).to be_a(Integer)
    end

    it 'should return a map of the level provided' do
      level = 3
      map = MapFactory.create_map(num_rooms, level)
      expect(map[:level]).to be(3)
    end

    it 'should return a map of level 1 when no level is provided' do
      map = MapFactory.create_map(num_rooms)
      expect(map[:level]).to be(1)
    end

    it 'should return a map with the number of rooms sent in' do
      map = MapFactory.create_map(num_rooms, level)
      counted_rooms = count_rooms(map[:tiles])
      expect(counted_rooms).to be(num_rooms)
    end
  end
end

def count_rooms(tiles)
  tiles.values.count { |tile| tile.type == 'room' } - 1
end
