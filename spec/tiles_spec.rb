require_relative './spec_helper.rb'
require 'require_all'
require_rel '../lib/dungeon/map/tiles'

describe Tile do
  describe 'When a tile tile is created' do
    grid_point = [0, 0]
    up = false

    it 'should have all the expected attributes' do
      tile = Tile.new(grid_point, up)
      expect(tile.grid_point).to eq(grid_point)
      expect(tile.connections).to eq({})
      expect(tile.directions).to eq({})
      expect(tile.down).to eq(false)
      expect(tile.up).to eq(up)
    end

    it 'should set up to false if not given' do
      tile = Tile.new(grid_point)
      expect(tile.up).to eq(false)
    end

    it 'should have the icon U if the tile is set to up' do
      tile = Tile.new(grid_point, true)
      expect(tile.icon).to eq('U ')
    end
  end
end

describe Hall do
  describe 'When a hall tile is created' do
    grid_point = [0, 0]
    up = false

    it 'should have the proper type and icon' do
      hall = Hall.new(grid_point, up)
      expect(hall.type).to eq('hall')
      expect(hall.icon).to eq('h ')
    end
  end
end

describe Room do
  describe 'When a room tile is created' do
    grid_point = [0, 0]
    up = false

    it 'should have the proper type and icon' do
      room = Room.new(grid_point, up)
      expect(room.type).to eq('room')
      expect(room.icon).to eq('r ')
    end
  end
end
