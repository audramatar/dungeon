require_relative './basic_ui.rb'

# UI for characters with user controlled combat
module ControlledCharacterUI
  include BasicUI

  def which_enemy(opponents)
    living_enemies = opponents.find_all(&:alive)
    enemy_names = living_enemies.collect { |opp| "#{opp.party_number}. #{opp.name}" }
    error = nil

    while true # Fix this in the future!
      print_error_message(error) if error
      tip = 'Enter the party number that appears before the name.'
      answer = ask_question('Which enemy would you like to target?', [tip], enemy_names).downcase
      target = living_enemies.find { |opp| opp.party_number == answer.to_i }
      return target if target
      error = "#{answer} is not a valid choice. Make sure you are selecting the party number from the list."
    end
  end
end