require_relative("entity")
require 'json'
class Character < Entity
  @experience = -1
  @armor = 0
  @shield = 0
  @inventory = []

  def initialize
    @experience = 0
    @armor = 0
    @shield = 0
    set_maximum_hit_points(10)
    set_hit_points(10)
    set_money(0)
    set_weapon(0)
    set_level(1)
	set_inventory([])
  end

  def set_experience(exp)
    @experience = exp
  end
  def get_experience
    @experience
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
  def set_armor(arm)
    @armor = arm
  end
  def get_armor
    @armor
  end
  def set_shield(shield)
    @shield = shield
  end
  def get_shield
    @shield
  end
  def get_character
    f = File.open('c.json', 'r')
    config = JSON.load(f)
  end
  def weaponname(wn)
    'Fists' if wn == 0
  end
  def armorname(an)
    'None' if an == 0
  end
  def shieldname(sn)
    'None' if sn == 0
  end

  def display
    puts '****************'
    puts "Name:   #{get_name}"
    puts "HP:     #{get_hit_points} of #{get_maximum_hit_points}"
    puts "Level:  #{get_level}"
    puts "Weapon: #{weaponname(get_weapon)}"
    puts "Armor:  #{armorname(get_armor)}"
    puts "Shield: #{shieldname(get_shield)}"
    puts "Coin:   #{get_money}"
    puts "Exp:    #{get_experience}"
	puts "Inv:    #{get_inventory}"
    puts '****************'
  end

  def loadchar
    set_name(get_character['character']['name'])
    set_maximum_hit_points(get_character['character']['mhp'])
    set_hit_points(get_character['character']['hp'])
    set_level(get_character['character']['level'])
    set_weapon(get_character['character']['weapon'])
    set_armor(get_character['character']['armor'])
    set_shield(get_character['character']['shield'])
    set_money(get_character['character']['coin'])
    set_experience(get_character['character']['exp'])
    set_inventory(get_character['character']['inv'])
  end
  def save
    outfile = open('c.json', 'w')
    outfile.write ("{\n")
    outfile.write ("    \"character\" :\n")
    outfile.write ("    {\n")
    outfile.write ("        \"name\" : \"#{get_name}\",\n")
    outfile.write ("        \"mhp\" : #{get_maximum_hit_points},\n")
    outfile.write ("        \"hp\" : #{get_hit_points},\n")
    outfile.write ("        \"level\" : #{get_level},\n")
    outfile.write ("        \"weapon\" : #{get_weapon},\n")
    outfile.write ("        \"armor\"  : #{get_armor},\n")
    outfile.write ("        \"shield\" : #{get_shield},\n")
    outfile.write ("        \"coin\" : #{get_money},\n")
    outfile.write ("        \"exp\" : #{get_experience},\n")
    outfile.write ("        \"inv\" : #{get_inventory}\n")
    outfile.write ("    }\n")
    outfile.write ("}\n")
    outfile.close
  end
end