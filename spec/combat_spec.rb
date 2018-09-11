require 'require_all'
require_relative './spec_helper.rb'
require_relative '../lib/game/combat/combat_instance.rb'
require_rel '../lib/characters'
require_rel '../lib/dungeon/map/tiles'

describe CombatInstance do
  describe 'When a combat instance is initialized' do
    character = EnemyCharacter.new
    enemy = EnemyCharacter.new
    encounter_details = { encounter: true, level: 1, stairs_set: true, last_room: false }
    room = Room.new([0, 0], encounter_details)
    encounter_type = 'normal'
    combat = CombatInstance.new(character.party, enemy.party, encounter_type, room)

    it 'places all characters on the combat grid' do
      expect(combat.grid.count).to be(2)
      expect(combat.grid.values).to include(character)
      expect(combat.grid.values).to include(enemy)
    end

    describe 'when combat is started' do
      enemy.take_damage(enemy.max_hp + 10)
      it 'successfully ends and returns a victor when one side is dead' do
        expect(combat.fight).to eq('pc')
      end
    end
  end
end
