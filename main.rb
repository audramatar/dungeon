require_relative 'lib/dungeon/dungeon.rb'

dungeon = Dungeon.new(6)

dungeon.print_map(1, dungeon.dungeon[1])

previous = nil
tile = [0,0]
while true
  dungeon.print_tile_details(tile, previous)
  puts "where do you want to go?"
  print "> "
  previous = tile
  tile = dungeon.dungeon[1][tile].directions[gets.chomp]
  if dungeon.dungeon[1][tile].encounter
    puts dungeon.dungeon[1][tile].encounter
  end
  break if tile == 'exit'
end
