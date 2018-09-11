require_relative './basic_ui.rb'

# Module to add UI to combat
module CombatUI
  include BasicUI

  def display_combat_map(grid, size, enemy_party)
    clear_screen
    display_combat_grid(grid, size, enemy_party)
    display_combat_grid_key
  end

  def display_combat_grid(grid, size, enemy_party)
    print_line
    puts Paint['COMBAT GRID', :bold]
    print_line
    (0..(size[1] - 1)).reverse_each do |y|
      (0..(size[0] - 1)).each do |x|
        if grid[[x, y]]
          if enemy_party.include?(grid[[x, y]])
            print "e#{grid[[x, y]].party_number} ".ljust(4)
          else
            print "p#{grid[[x, y]].party_number} ".ljust(4)
          end
        else
          print '.'.ljust(4)
        end
      end
      new_line
    end
  end

  def display_combat_grid_key
    print_line
    puts Paint['KEY', :bold]
    puts Paint['p#', :bold] + ' = player and ally locations with party number'
    puts Paint['e#', :bold] + ' = enemy locations with party number'
    puts Paint['.', :bold] + ' = unblocked tile representing 5ft'
    print_line
  end
end
