require_relative './encounter.rb'

# Factory that creates a random monster encounter based on the level of the dungeon.
class StairsEncounter < Encounter
  def initialize(level, variation)
    @variation = variation # variation can be up or down
    @type = "stairs #{variation}"
    super(level)
  end

  def fill_description
    @description = if @variation == 'up'
                     'There are some stairs up to the previous level here!'
                   elsif @variation == 'down'
                     'There are some stairs that seem to go down to the next level here!'
                   end
  end
end
