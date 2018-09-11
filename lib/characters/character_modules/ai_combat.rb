# Combat skills for characters not controlled by the player
module AICombat
  def attack(opponents)
    living_enemies = opponents.find_all(&:alive)
    attack_object = auto_attack
    attack_object[:target] = living_enemies.sample
    attack_object[:name] = @name
    attack_object
  end
end
