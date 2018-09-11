require_relative './basic_ui.rb'

# Module for all character UI
module CharacterUI
  include BasicUI

  def character_header(party, title)
    puts ''.ljust(10) + Paint[title.upcase, :bold]
    party.each_with_index do |character, index|
      character_tile(character, (index + 1))
    end
  end

  def character_tile(character, party_number)
    print_line
    puts Paint["#{party_number}. #{character.name.upcase}", :bold]
    print "Level: #{character.level}".ljust(10)
    if character.alive
      puts 'Status: ' + Paint['ALIVE', :bold]
    else
      puts 'Status: ' + Paint['DEAD', :red, :bold]
    end
    puts "HP: #{character.hp}/#{character.max_hp}".ljust(10) + "Mana: #{character.mana}/#{character.max_mana}".ljust(10)
  end
end
