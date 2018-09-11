require_relative '../UI/character_ui.rb'
require_relative './character_modules/character_combat.rb'

# Base class for all characters that show up in the game.
class Character
  attr_reader :name, :alive, :party, :party_number
  attr_reader :initiative, :level, :hp, :max_hp, :mana, :max_mana, :ac

  include CharacterUI
  include CharacterCombat

  def initialize
    @alive = true
    @name = ''
    @level = 1
    @hp = 10
    @max_hp = 10
    @mana = 100
    @max_mana = 100
    @ac = 13
    @initiative = rand(1..20)
  end

  def add_ally_to_party(ally)
    @party.push(ally)
    ally.join_party(@party, @party.length)
  end

  def join_party(party, party_number)
    @party_number = party_number
    @party = party
  end

  def take_damage(damage)
    @hp -= damage
    @hp = 0 if @hp < 0
    @alive = false if @hp <= 0
  end

  def heal(points)
    @hp += points
    @hp = @max_hp if @hp > @max_hp
    @alive = true if @hp > 0
  end
end
