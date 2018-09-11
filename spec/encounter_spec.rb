require_relative './spec_helper.rb'
require 'require_all'
require_rel '../lib/dungeon/map/encounters'
require_rel '../lib/characters'
require_rel '../lib/dungeon/map/tiles'

describe Encounter do
end

describe MonsterEncounter do
  context 'When a monster encounter is activated' do
    grid_point = [0, 0]
    no_encounter = { encounter: false, level: 1, stairs_set: true, last_room: false }
    location = Tile.new(grid_point, no_encounter)
    player = EnemyCharacter.new
    encounter = MonsterEncounter.new(1)

    it 'completes a combat loop and returns a victor' do
      possible_victors = ['pc', 'enemy']
      allow(encounter).to receive(:gets).and_return('')
      victor = encounter.activate(player.party, location)
      expect(possible_victors).to include(victor)
    end
  end
end

describe DistressedHumanoidEncounter do
end

describe PuzzleEncounter do
end

describe StairsEncounter do
end

describe TrapEncounter do
end

describe TreasureEncounter do
end
