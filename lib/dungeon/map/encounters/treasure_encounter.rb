require_relative './encounter.rb'

# Factory that creates a random monster encounter based on the level of the dungeon.
class TreasureEncounter < Encounter

  def initialize(level, variation = 'normal')
    @variation = variation # variation can be normal or mimic
    @type = "treasure, #{variation}"
    super(level)
  end

  def fill_description
    @description = if @variation == 'mimic'
                     "Oh look, a totally unassuming treasure chest that totally doesn't look dangerous at all."
                   else
                     'You found some treasure! Happy day!'
                   end
  end
end
