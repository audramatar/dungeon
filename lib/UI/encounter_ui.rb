require_relative './basic_ui.rb'

# Module for all encounter UI needs.
module EncounterUI
  include BasicUI

  def display_combat_results(victor)
    clear_screen
    if victor == 'enemy'
      puts 'You have been defeated!'
    elsif victor == 'pc'
      puts 'Victory! You have won!'
    end
    pause
  end
end
