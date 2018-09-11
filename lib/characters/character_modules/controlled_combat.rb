# Combat module for characters that are controlled by the player
module ControlledCombat
  def attack(opponents)
    attack_object = auto_attack
    attack_object[:target] = which_enemy(opponents)
    attack_object[:name] = @name
    attack_object
  end
end
