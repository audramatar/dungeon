require_relative './spec_helper.rb'
require_relative '../lib/dungeon/dungeon.rb'

describe Dungeon do
  context 'When creating a new dungeon' do
    min_rooms = 5

    it 'should create a dungeon with one level at level 1' do
      dungeon = Dungeon.new(min_rooms)
      expect(dungeon.maps).to be_a(Hash)
      expect(dungeon.maps.keys).to eq([1])
      expect(dungeon.maps[1]).to be_a(Hash)
    end
  end

  context 'When adding a level in the dungeon' do
    min_rooms = 5
    dungeon = Dungeon.new(min_rooms)

    it 'should create a new map one level higher than the previous level and add it to maps' do
      dungeon.add_level(min_rooms)
      expect(dungeon.maps.keys).to eq([1, 2])
      expect(dungeon.maps[1]).to be_a(Hash)
      expect(dungeon.maps[1][:level]).to eq(1)
      expect(dungeon.maps[2]).to be_a(Hash)
      expect(dungeon.maps[2][:level]).to eq(2)
    end
  end
end
