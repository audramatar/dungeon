require_relative './encounter.rb'

# Factory that creates a random monster encounter based on the level of the dungeon.
class TrapEncounter < Encounter

  def initialize(level)
    @type = 'trap'
    super(level)
  end

  def fill_description
    @description = "Oh no! It's a trap!"
  end
end
