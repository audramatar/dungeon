# Factory that creates a random monster encounter based on the level of the dungeon.
class MonsterEncounterFactory
  def self.generate_monster_encounter(level)
    "#{(1..4).sample * level} monsters show up!"
  end
end
