require_relative '../file_helper.rb'
require_relative './character.rb'

# Class for any ally characters.
class AllyCharacter < Character
  def initialize
    super
    @party = [self]
    @party_number = 1
    @name = 'Ally'
  end
end
