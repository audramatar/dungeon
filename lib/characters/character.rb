# Base class for all characters that show up in the game.
class Character
  attr_reader :name, :level, :hp, :max_hp, :mana, :max_mana

  def initialize
    @name = "test"
    @level = 1
    @hp = 10
    @max_hp = 10
    @mana = 100
    @max_mana = 100
  end
end
