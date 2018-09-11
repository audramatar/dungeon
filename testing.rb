require 'require_all'
require 'byebug'
require_relative './lib/game/combat/combat_instance.rb'
require_rel './lib/characters'
require_rel './lib/dungeon'

@pc = PlayerCharacter.new
@ally = AllyCharacter.new
@pc.add_ally_to_party(@ally)

@enemy1 = EnemyCharacter.new
@enemy2 = EnemyCharacter.new
@enemy1.add_ally_to_party(@enemy2)

grid_point = [0, 0]
encounter_details = { encounter: false, level: 1, stairs_set: true, last_room: false }
up = false
room = Room.new(grid_point, encounter_details, up)

combat = CombatInstance.new(@pc.party, @enemy1.party, 'regular', room)
combat.fight

