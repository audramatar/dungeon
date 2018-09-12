require_relative './basic_ui.rb'

# Module for all character UI
module CharacterUI
  include BasicUI

  def character_header(party, title)
    puts Paint[title.upcase, :bold]
    print_line
    lines = party.length / 2
    lines + 1 if party.length.odd?
    index = 0
    lines.times do
      character1 = party[index]
      character2 = party[index+1] if party[index+1]
      character_tile(character1, character2)
      index += 2
    end
  end

  def character_tile(character1, character2 = nil)
    print Paint["#{character1.party_number}. #{character1.name.upcase}".ljust(30), :bold]
    print Paint["#{character2.party_number}. #{character2.name.upcase}".ljust(20), :bold] if character2
    new_line
    print "Level: #{character1.level}".ljust(10)
    if character1.alive
      print 'Status: ' + Paint['ALIVE'.ljust(12), :bold]
    else
      print 'Status: ' + Paint['DEAD'.ljust(12), :red, :bold]
    end
    if character2
      print "Level: #{character2.level}".ljust(10)
      if character2.alive
        print 'Status: ' + Paint['ALIVE'.ljust(20), :bold]
      else
        print 'Status: ' + Paint['DEAD'.ljust(20), :red, :bold]
      end
    end
    new_line
    print "HP: #{character1.hp}/#{character1.max_hp}".ljust(10) +
         "Mana: #{character1.mana}/#{character1.max_mana}".ljust(20)
    if character2
      print "HP: #{character2.hp}/#{character2.max_hp}".ljust(10) +
         "Mana: #{character2.mana}/#{character2.max_mana}".ljust(10)
    end
    new_line(2)
  end
end
