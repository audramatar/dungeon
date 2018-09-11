require_relative './spec_helper.rb'
require 'require_all'
require_rel '../lib/dungeon/map/tiles'
require_rel '../lib/characters'

describe Tile do
  describe 'When a tile tile is created' do
    grid_point = [0, 0]
    no_encounter = { encounter: false, level: 1, stairs_set: true, last_room: false }
    up = false

    it 'should have all the expected attributes' do
      tile = Tile.new(grid_point, no_encounter, up)
      expect(tile.grid_point).to eq(grid_point)
      expect(tile.connections).to eq({})
      expect(tile.directions).to eq({})
      expect(tile.down).to eq(false)
      expect(tile.up).to eq(up)
      expect(tile.encounter).to eq(nil)
      expect(tile.description).to be_a(String)
    end

    it 'should set up to false if not given' do
      tile = Tile.new(grid_point, no_encounter)
      expect(tile.up).to eq(false)
    end

    it 'should have the icon U if the tile is set to up' do
      tile = Tile.new(grid_point, no_encounter, true)
      expect(tile.icon).to eq('U ')
    end

    context 'when an encounter is set' do
      encounter_details = { encounter: true, level: 1, stairs_set: true, last_room: false }

      it 'should be set at the level sent in' do
        encounter_details[:level] = 2
        tile = Tile.new(grid_point, encounter_details, up)
        expect(tile.encounter.level).to eq(2)
      end

      it 'should set the encounter to stairs down if it is the last room and stairs down have not beeen set' do
        encounter_details[:stairs_set] = false
        encounter_details[:last_room] = true
        tile = Tile.new(grid_point, encounter_details, up)
        expect(tile.encounter.type).to eq('stairs down')
      end

      it 'should set the encounter to stairs up if it is the first room on the map' do
        up = true
        tile = Tile.new(grid_point, encounter_details, up)
        expect(tile.encounter.type).to eq('stairs up')
      end

      it "should set the tile's description to the encounter's description" do
        tile = Tile.new(grid_point, encounter_details, up)
        expect(tile.description).to eq(tile.encounter.description)
      end
    end
  end

  context "When a tile's encounter is tripped" do
    grid_point = [0, 0]
    encounter = { encounter: true, level: 1, stairs_set: true, last_room: false }
    character = EnemyCharacter.new
    tile = Tile.new(grid_point, encounter)

    it 'runs the encounter and removes it' do
      tile.activate_encounter(character.party)
      expect(tile.encounter).to be(nil)
    end
  end
end

describe Hall do
  describe 'When a hall tile is created' do
    grid_point = [0, 0]
    encounter_details = { encounter: false, level: 1, stairs_set: true, last_room: false }
    up = false

    it 'should have the proper type and icon' do
      hall = Hall.new(grid_point, encounter_details, up)
      expect(hall.type).to eq('hall')
      expect(hall.icon).to eq('h ')
      expect(hall.size).to be_a(Array)
    end
  end
end

describe Room do
  describe 'When a room tile is created' do
    grid_point = [0, 0]
    encounter_details = { encounter: false, level: 1, stairs_set: true, last_room: false }
    up = false

    it 'should have the proper type and icon' do
      room = Room.new(grid_point, encounter_details, up)
      expect(room.type).to eq('room')
      expect(room.icon).to eq('r ')
      expect(room.size).to be_a(Array)
    end
  end
end
