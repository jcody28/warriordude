require_relative("entity")
class Character < Entity
  @experience = -1
  @armor = ""
  @shield = ""

  def initialize
    @experience = 0
    @armor = 0
    @shield = 0
  end

  def set_experience(exp)
    @experience = exp
  end
  def get_experience
    @experience
  end
  def set_armor(arm)
    @armor = arm
  end
  def get_armor
    @armor
  end
  def set_shield(shield)
    @shield = shield
  end
  def weaponname(wn)
    "Fists" if wn = 0
  end
end