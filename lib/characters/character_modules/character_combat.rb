# Module for combat that all characters need
module CharacterCombat
  def defend(attack_object)
    if attack_object[:attack] >= @ac
      take_damage(attack_object[:damage])
      "#{attack_object[:name]}'s attack hits! #{@name} took #{attack_object[:damage]} damage!"
    else
      "#{attack_object[:name]}'s attack missed #{@name}!"
    end
  end

  private

  def auto_attack
    attack = rand(1..20)
    damage = rand(1..4)
    { attack: attack, damage: damage }
  end
end
