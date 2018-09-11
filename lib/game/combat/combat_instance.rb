require_relative '../../file_helper.rb'
require_relative '../../UI/combat_ui.rb'

# A class to generate an instance of combat
class CombatInstance
  include CombatUI

  attr_reader :grid # REMOVE THIS AFTER TESTING!

  def initialize(pc_party, enemy_party, encounter_type, location)
    @pc_party = pc_party
    @enemy_party = enemy_party
    @encounter_type = encounter_type
    @location = location
    @grid = {}
    @message = []
    place_players_on_grid
    @turn_list = []
    generate_turn_list
  end

  # make sure there is a max party size and max enemey size to avoid grids that don't fit all players!
  def place_players_on_grid
    set_pc_party_on_grid
    set_enemy_party_on_grid
  end

  def fight
    while continue_combat?
      puts @turn_list.map(&:initiative)
      puts @turn_list.map(&:name)
      @turn_list.each do |character|
        puts "#{character.name} is taking a turn!"
        display_combat_map(@grid, @location.size, @enemy_party, @pc_party, @message)
        if @pc_party.include?(character)
          @message = []
          turn(character, @enemy_party)
        else
          turn(character, @pc_party)
        end
        break unless continue_combat?
      end
    end
  end

  def turn(character, opponents)
    attack_object = character.attack(opponents)
    @message.push(attack_object[:target].defend(attack_object))
  end

  private

  def continue_combat?
    return false if @pc_party.count(&:alive).zero?
    return false if @enemy_party.count(&:alive).zero?
    true
  end

  def generate_turn_list
    @turn_list.concat(@pc_party, @enemy_party)
    @turn_list.sort_by!(&:initiative).reverse!
  end

  def set_pc_party_on_grid
    y = 0
    x = 0
    ally_index = 0
    until ally_index == @pc_party.length
      if x < @location.size[0] && @grid[[x, y]].nil?
        @grid[[x, y]] = @pc_party[ally_index]
        ally_index += 1
        x += 1
      else
        y += 1
        x = 0
      end
    end
  end

  def set_enemy_party_on_grid
    enemy_index = 0
    until enemy_index == @enemy_party.length
      x = rand(0..(@location.size[0] - 1))
      y = rand(0..(@location.size[1] - 1))
      unless @grid[[x, y]]
        @grid[[x, y]] = @enemy_party[enemy_index]
        enemy_index += 1
      end
    end
  end
end
