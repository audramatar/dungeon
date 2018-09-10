require_relative '../file_helper.rb'
require_rel '../UI'
require_relative '../dungeon/dungeon.rb'
require_rel '../characters'

# Class to actually get the game going.
class Game
  include BasicUI
  include GameUI

  def start_game
    @continue = true
    answer = nil
    while @continue
      start_menu_display
      answer = ask_question
      case answer
      when 'quit'
        break
      when 'new'
        new_game
      when 'load'
        load_game
      end
    end
  end

  def new_game
    create_character
    enter_map
    turn while @continue
  end

  def confirm_quit
    answer = ask_question('Are you sure you want to quit? (yes/no)',
                          ['Any progress not saved will be lost!'])
    @continue = false if answer == 'yes'
  end

  def load_game
    puts 'game loaded'
    gets.chomp
  end

  def create_character
    @pc = PlayerCharacter.new
  end

  def show_character_map(map, location)
    system 'clear'
    x_max = map.keys.max_by { |x| x[0] }[0]
    y_max = map.keys.max_by { |y| y[1] }[1]
    x_min = map.keys.min_by { |x| x[0] }[0]
    y_min = map.keys.min_by { |y| y[1] }[1]

    draw_character_map(map, location, x_max, y_max, x_min, y_min)
  end

  def enter_map
    @dungeon = Dungeon.new(5)
    @map = @dungeon.maps[1]
    starting_point = @map[:stairs_up]
    starting_tile = @map[:tiles][starting_point]
    @pc.get_on_map(starting_point, starting_tile)
  end

  def main_menu
    error = nil
    while @continue
      main_menu_display
      print_error_message(error) if error
      error = nil
      answer = ask_question('What would you like to do?')
      case answer
      when 'return'
        break
      when 'map'
        system 'clear'
        show_character_map(@pc.map, @pc.location)
        pause
      when 'inventory'
      when 'save'
      when 'load'
      when 'quit'
        confirm_quit
      else
        error = "#{answer.upcase} is not a valid response. \n" +
                "Please choose from the menu."
      end
    end
  end

  def turn
    game_display('This is the description', [@pc, @pc])
    tips = ['Use north, south, east, or west for directions!', 'Type [menu] for more options!']
    direction = ask_question('Which way do you want to go?', tips)
    new_location = @pc.location.directions[direction]
    if direction == 'menu'
      main_menu
    elsif new_location.nil?
      print_error_message("That's not a valid direction! Please try again!")
    else
      @pc.move_on_map(@map[:tiles][new_location])
    end
  end
end
