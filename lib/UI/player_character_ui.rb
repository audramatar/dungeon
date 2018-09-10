require_relative './basic_ui.rb'

module PlayerCharacterUI
  include BasicUI

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
    puts Paint['r', :bold] + ' = room'.ljust(13) + Paint['h', :bold] + ' = hall'
    puts Paint['.', :bold] + ' = wall'.ljust(13) + Paint['C', :bold] + ' = You Are Here!'
    puts Paint['U', :bold] + ' = stairs up'.ljust(13) + Paint['D', :bold] + ' = stairs down'
    puts '-' * 30
  end
end
