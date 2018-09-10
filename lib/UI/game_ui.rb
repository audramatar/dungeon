# Adding UI specific for game-based utilities
module GameUI
  def start_menu_display
    system 'clear'
    puts "\n"
    puts ''.ljust(8) + Paint['Start Menu', :bold]
    puts '-' * 27
    puts "\n"
    puts '[ new ]'.ljust(9) + '[ load ]'.ljust(10) + '[ quit ]'
    puts "\n"
  end

  def main_menu_display
    system 'clear'
    puts "\n"
    puts ''.ljust(8) + Paint['Main Menu', :bold]
    puts '-' * 27
    puts "\n"
    puts '[ return ]'.ljust(11.5) + '[ map ]'.ljust(8.5) + '[ inventory ]'
    puts '[save]'.ljust(11) + '[ load ]'.ljust(13) + '[ quit ]'
    puts "\n"
  end

  def game_display(description, characters)
    system 'clear'
    character_header(characters)
    display_directions(characters.first)
    puts '-' * 30
    display_description(description)
  end

  def display_description(description)
    puts Paint[description, :red]
  end

  def display_directions(pc)
    west = false
    print ''.ljust(10) + Paint['MAP', :bold]
    print "\n"
    puts '-' * 30
    print "\n"
    print ''.ljust(10) + Paint['↑', :bold] if pc.location.directions.include?('north')

    print "\n"
    if pc.location.directions.include?('west')
      print ''.ljust(3) + Paint['←', :bold] 
      west = true
    end

    if pc.location.directions.include?('east')
      print ''.ljust(16) + Paint['→', :bold] unless west
      print ''.ljust(13) + Paint['→', :bold] if west
    end

    print "\n"
    print ''.ljust(10) + Paint['↓', :bold] if pc.location.directions.include?('south')
    print "\n\n"
  end

  def character_header(characters)
    puts ''.ljust(10) + Paint['CHARACTERS', :bold]
    characters.each do |character|
      character_tile(character)
    end
  end

  def character_tile(character)
    puts '-' * 30
    puts Paint[character.name.upcase, :italic]
    puts "Level: #{character.level}"
    puts "HP: #{character.hp}/#{character.max_hp}".ljust(10) + "HP: #{character.mana}/#{character.max_mana}".ljust(10)
    puts '-' * 30
  end

  def draw_character_map(map, location, x_max, y_max, x_min, y_min)
    puts Paint['YOUR MAP', :bold]
    puts '-' * 30
    (y_min..y_max).reverse_each do |y|
      (x_min..x_max).each do |x|
        if map[[x, y]].nil?
          print_icon(' ')
        elsif map[[x, y]] == 'wall'
          print_icon('.')
        elsif location.grid_point == [x, y]
          print_icon('C')
        else
          print_icon(map[[x, y]].icon)
        end
      end
      new_line(2)
    end
    puts '-' * 30
    puts Paint['KEY', :bold]
    puts  'You Are Here!: ' + Paint['C', :bold]
    puts 'Wall: ' + Paint['.'.ljust(2), :bold] + 'Hall: ' + Paint['h'.ljust(2), :bold] + 
         'Room: ' + Paint['r', :bold]
    puts '-' * 30
  end
end
