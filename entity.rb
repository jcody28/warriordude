class Entity
  @name = ""
  @maximumhitpoints = -1
  @hitpoints = -1
  @money
  @weapon

  def set_name(name)
    @name = name
  end
  def get_name
    @name
  end
  def set_maximum_hit_points(mhp)
    @maximumhitpoints = mhp
  end
  def get_maximum_hit_points
    @maximumhitpoints
  end
  def set_hit_points(hp)
    @hitpoints = hp
  end
  def get_hit_points
    @hitpoints
  end
  def set_money(cash)
    @money = cash
  end
  def get_money
    @money
  end
  def set_weapon(weapon)
    @weapon = weapon
  end
  def get_weapon
    @weapon
  end
end