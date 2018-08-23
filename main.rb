require_relative 'lib/dungeon/dungeon.rb'

dungeon = Dungeon.new(6)

dungeon.print_map(1, dungeon.dungeon[1])
