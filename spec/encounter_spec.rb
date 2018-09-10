require_relative './spec_helper.rb'
require 'require_all'
require_rel '../lib/dungeon/map/encounters'

describe Encounter do
end

describe MonsterEncounter do
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
  context 'When creating a Treasure encounter' do
    level = 1

    it 'should have all of the normal normal when sending in no variation' do
      encounter = TreasureEncounter.new(level)
      expect(encounter.type).to eq('treasure, normal')
    end

    it 'should have all of the normal normal when sending in the normal variation' do
      encounter = TreasureEncounter.new(level, 'normal')
      expect(encounter.type).to eq('treasure, normal')
    end

    it 'should have the mimic type when sending in the mimic variation' do
      encounter = TreasureEncounter.new(level, 'mimic')
      expect(encounter.type).to eq('treasure, mimic')
    end
  end
end
