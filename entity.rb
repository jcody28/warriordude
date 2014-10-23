class Entity
  @name = ""
  @maximumhitpoints = -1
  @hitpoints = -1
  @money
  @weapon
  @armor
  @shield
  @level
  @inventory = []
  
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
  def set_level(lev)
    lev = 1 if lev < 1
    @level = lev
  end
  def set_hit_points(hp)
    @hitpoints = hp
  end
  def get_hit_points
    @hitpoints
  end
  def get_level
    @level
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
  def sheathe_weapon
    if @weapon != 0
	  add_inventory(@weapon)
	  set_weapon(0)
	end
  end
  def set_armor(arm)
    @armor = arm
  end
  def get_armor
    @armor
  end
  def remove_armor
    if @armor != 0
      add_inventory(@armor)
      set_armor(0)
    end
  end
  def set_shield(shield)
    @shield = shield
  end
  def get_shield
    @shield
  end
  def remove_shield
    if @shield != 0
      add_inventory(@shield)
      set_shield(0)
    end
  end
  def set_inventory(item_list)
    @inventory = item_list
  end
  def get_inventory
    @inventory
  end
  def add_inventory(item)
    @inventory << item
  end
  def remove_inventory(item)
    @inventory.delete(item)
  end
  def equip_item(item)
    if item.type == "weapon"
      sheathe_weapon
	  set_weapon(item)
    elsif item.type == "armor"
      remove_armor
      set_armor(item)
    elsif item.type == "shield"
      remove_shield
      set_shield(item)
    end
  end
end