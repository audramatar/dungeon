require_rel '../encounters'

# A tile is a space that a player can reach within a map. This is a parent class for
# hall and room.
class Tile
  attr_reader :type, :is_start, :grid_point, :encounter, :down, :up, :icon, :description, :size
  attr_accessor :connections, :directions

  def initialize(grid_point, encounter_details, up = false)
    @grid_point = grid_point
    @connections = {}
    @directions = {}
    @down = false
    @up = up
    @size = [4, 4]
    @icon = 'U ' if @up

    if encounter_details[:encounter]
      decide_on_encounter(encounter_details[:level], encounter_details[:stairs_set],
                          encounter_details[:last_room])
    else
      @encounter = nil
    end

    set_description
  end

  def activate_encounter(pc_party)
    @encounter.activate(pc_party, self)
    complete_encounter
  end

  def complete_encounter
    @encounter = nil
    set_description
  end

  def decide_on_encounter(level, stairs_set, last_room)
    encounters = [MonsterEncounter.new(level), MonsterEncounter.new(level, 'boss'),
                  MonsterEncounter.new(level, 'miniboss'),
                  TrapEncounter.new(level), PuzzleEncounter.new(level), DistressedHumanoidEncounter.new(level, 'trap'),
                  DistressedHumanoidEncounter.new(level, 'ally'), TreasureEncounter.new(level),
                  TreasureEncounter.new(level, 'mimic')]

    encounters.push(StairsEncounter.new(level, 'down')) if @type == 'room' && !stairs_set

    if @up
      set_encounter(StairsEncounter.new(level, 'up'))
    elsif last_room && !stairs_set
      set_encounter(StairsEncounter.new(level, 'down'))
    else
      set_encounter(encounters.sample)
    end

    @down = true if @encounter.type == 'stairs down'
    @icon = 'D ' if @down
  end

  def set_encounter(encounter)
    @encounter = encounter
  end

  def set_description
    @description = if @encounter
                     @encounter.description
                   else
                     'An empty hallway. What lays in wait ahead?'
                   end
  end
end
