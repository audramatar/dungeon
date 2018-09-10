require_relative './basic_ui.rb'

# Adding UI specific for game-based utilities
module GameUI
  include BasicUI

  def start_menu_display
    system 'clear'
    new_line
    puts ''.ljust(8) + Paint['Start Menu', :bold]
    print_line
    new_line
    puts '[ new ]'.ljust(9) + '[ load ]'.ljust(10) + '[ quit ]'
    new_line
  end

  def main_menu_display
    system 'clear'
    new_line
    puts ''.ljust(10) + Paint['Main Menu', :bold]
    print_line
    new_line
    puts '[ return ]'.ljust(11.5) + '[ map ]'.ljust(8.5) + '[ inventory ]'
    puts '[save]'.ljust(11) + '[ load ]'.ljust(13) + '[ quit ]'
    new_line
    print_line
  end

  def game_display(description, characters)
    clear_screen
    character_header(characters)
    display_directions(characters.first)
    print_line
    display_description(description)
  end

  def display_description(description)
    puts Paint[description, :red]
  end

  def display_directions(pc)
    west = false
    print ''.ljust(10) + Paint['MAP', :bold]
    new_line
    print_line
    new_line
    print ''.ljust(10) + Paint['↑', :bold] if pc.location.directions.include?('north')

    new_line
    if pc.location.directions.include?('west')
      print ''.ljust(3) + Paint['←', :bold] 
      west = true
    end

    if pc.location.directions.include?('east')
      print ''.ljust(16) + Paint['→', :bold] unless west
      print ''.ljust(13) + Paint['→', :bold] if west
    end

    new_line
    print ''.ljust(10) + Paint['↓', :bold] if pc.location.directions.include?('south')
    new_line(2)
  end

  def character_header(characters)
    puts ''.ljust(10) + Paint['CHARACTERS', :bold]
    characters.each do |character|
      character_tile(character)
    end
  end

  def character_tile(character)
    print_line
    puts Paint[character.name.upcase, :italic]
    puts "Level: #{character.level}"
    puts "HP: #{character.hp}/#{character.max_hp}".ljust(10) + "HP: #{character.mana}/#{character.max_mana}".ljust(10)
    print_line
  end
end
