require_relative './basic_ui.rb'

# Adding UI specific for game-based utilities
module GameUI
  include BasicUI

  def start_menu_display
    system 'clear'
    new_line
    puts ''.ljust(20) + Paint['Start Menu', :bold]
    print_line
    new_line
    puts ''.ljust(13) + '[ new ]'.ljust(9) + '[ load ]'.ljust(10) + '[ quit ]'
    new_line
  end

  def main_menu_display
    system 'clear'
    new_line
    puts ''.ljust(25) + Paint['Main Menu', :bold]
    print_line
    new_line
    puts '[ return ]'.ljust(13) + '[ inventory ]'.ljust(16) + '[save]'.ljust(10) + '[ load ]'.ljust(13) + '[ quit ]'
    new_line
    print_line
  end

  def game_display(description, characters)
    pc = characters.first
    clear_screen
    pc.character_header(pc.party, 'characters')
    pc.show_character_map(pc.map, pc.location)
    print_line
    display_description(description)
  end

  def display_description(description)
    puts Paint[description, :red]
  end

  def game_over
    clear_screen
    puts Paint['GAME OVER', :bold]
    pause
  end
end
