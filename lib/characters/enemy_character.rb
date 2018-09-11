require_relative '../file_helper.rb'
require_relative './character.rb'
require_relative './character_modules/ai_combat.rb'

# Class for any ally characters.
class EnemyCharacter < Character
  include AICombat

  def initialize
    super
    @name = 'Enemy'
  end
end
