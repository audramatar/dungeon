require_relative './encounter.rb'

# Factory that creates a random monster encounter based on the level of the dungeon.
class PuzzleEncounter < Encounter

  def initialize(level)
    @type = 'puzzle'
    super(level)
  end

  def fill_description
    @description = 'There looks to be a puzzle in this room!'
  end
end
