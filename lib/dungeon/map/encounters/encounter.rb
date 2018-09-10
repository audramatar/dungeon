require_relative '../../../file_helper.rb'
require_relative '../../../UI/encounter_ui.rb'

# Base class for all encounters in the game.
class Encounter
  attr_reader :level, :description, :type

  def initialize(level)
    @level = level
    fill_description
  end

  def fill_description
    # Made in child classes
  end
end
