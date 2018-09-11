require_relative '../file_helper.rb'
require_relative './character.rb'
require_relative './character_modules/controlled_combat.rb'
require_relative '../UI/controlled_character_ui.rb'

# Class for any ally characters.
class AllyCharacter < Character
  include ControlledCombat
  include ControlledCharacterUI

  def initialize
    super
    @name = 'Ally'
  end
end
