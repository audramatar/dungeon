require_relative './encounter.rb'

# Factory that creates a random monster encounter based on the level of the dungeon.
class DistressedHumanoidEncounter < Encounter

  def initialize(level, variation)
    @variation = variation # variation can be ally or trap
    @type = "distressed humanoid, #{variation}"
    super(level)
  end

  def fill_description
    @description = if @variation == 'ally'
                     'Someone requires your help! They appear to be friendly and want to join!'
                   else
                     "Someone looks to need your help! But it's a trap!"
                   end
  end
end
