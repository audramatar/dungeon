require_relative './encounter.rb'
require_relative '../../../characters/enemy_character.rb'
require_relative '../../../game/combat/combat_instance.rb'

# Factory that creates a random monster encounter based on the level of the dungeon.
class MonsterEncounter < Encounter
  def initialize(level, variation = 'normal')
    @variation = variation # variation can be normal, miniboss, or boss
    @type = "#{variation} monster"
    super(level)
  end

  def activate(pc_party, location)
    enemy1 = EnemyCharacter.new
    enemy2 = EnemyCharacter.new
    enemy1.add_ally_to_party(enemy2)

    combat = CombatInstance.new(pc_party, enemy1.party, @variation, location)
    victor = combat.fight
    display_combat_results(victor)
    victor
  end

  private

  def fill_description
    @description = if @variation == 'normal'
                     'Some monsters jump out at you! Ahh!!'
                   elsif @variation == 'miniboss'
                     'A monster approaches! This guy looks tough!'
                   elsif @variation == 'boss'
                     'DUN DUN DUN! BOSS MUSIC INTENSIFIES!'
                   end
  end
end
