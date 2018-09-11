require_relative '../UI/character_ui.rb'

# Base class for all characters that show up in the game.
class Character
  attr_reader :name, :level, :hp, :max_hp, :mana, :max_mana, :party, :party_number

  include CharacterUI

  def initialize
    @name = ''
    @level = 1
    @hp = 10
    @max_hp = 10
    @mana = 100
    @max_mana = 100
  end

  def add_ally_to_party(ally)
    @party.push(ally)
    ally.join_party(@party, @party.length)
  end

  def join_party(party, party_number)
    @party_number = party_number
    @party = party
  end
end
