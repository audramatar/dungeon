require_relative './encounter.rb'

# Factory that creates a random monster encounter based on the level of the dungeon.
class MonsterEncounter < Encounter

  def initialize(level, variation = 'normal')
    @variation = variation # variation can be normal, miniboss, or boss
    @type = "#{variation} monster"
    super(level)
  end

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
