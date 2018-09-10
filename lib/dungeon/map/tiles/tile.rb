require_rel '../encounters'

# A tile is a space that a player can reach within a map. This is a parent class for
# hall and room.
class Tile
  attr_reader :type, :is_start, :grid_point, :encounter, :down, :up, :icon, :description
  attr_accessor :connections, :directions

  def initialize(grid_point, encounter_details, up = false)
    @grid_point = grid_point
    @connections = {}
    @directions = {}
    @down = false
    @up = up
    @icon = 'U ' if @up

    if encounter_details[:encounter]
      set_encounter(encounter_details[:level], encounter_details[:stairs_set],
                    encounter_details[:last_room])
    else
      @encounter = nil
    end

    set_description
  end

  def print_valid_directions(previous)
    @directions.each do |direction, point|
      if point == previous
        puts direction.ljust(10) + ' => '.ljust(10) + @connections[point].type + ' (back the way you came)'
      elsif @connections[point].up
        puts direction.ljust(10) + ' => '.ljust(10) + 'back to start'
      else
        puts direction.ljust(10) + ' => '.ljust(10) + @connections[point].type
      end
    end
  end

  def set_encounter(level, stairs_set, last_room)
    encounters = [MonsterEncounter.new(level), MonsterEncounter.new(level, 'boss'),
                  MonsterEncounter.new(level, 'miniboss'),
                  TrapEncounter.new(level), PuzzleEncounter.new(level), DistressedHumanoidEncounter.new(level, 'trap'),
                  DistressedHumanoidEncounter.new(level, 'ally'), TreasureEncounter.new(level),
                  TreasureEncounter.new(level, 'mimic')]

    encounters.push(StairsEncounter.new(level, 'down')) if @type == 'room' && !stairs_set

    @encounter = if @up
                   StairsEncounter.new(level, 'up')
                 elsif last_room && !stairs_set
                   StairsEncounter.new(level, 'down')
                 else
                   encounters.sample
                 end

    @down = true if @encounter.type == 'stairs down'
    @icon = 'D ' if @down
  end

  def set_description
    @description = if @encounter
                     @encounter.description
                   else
                     'An empty hallway. What lays in wait ahead?'
                   end
  end
end
