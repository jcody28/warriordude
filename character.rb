#Imports
require_relative("entity")
require 'json'

#Non Class Methods
def createchar
  puts "Enter your player's name."
  pn = gets.chomp
  character = Character.new
  character.set_name(pn)
  character.save
  character.display
end

#Classes
class Character < Entity
  @experience = -1
  
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
  def display
    puts '****************'
    puts "Name:   #{get_name}"
    puts "HP:     #{get_hit_points} of #{get_maximum_hit_points}"
    puts "Level:  #{get_level}"
    puts "Weapon: #{weaponname(get_weapon)}"
    puts "Armor:  #{equipname(get_armor)}"
    puts "Shield: #{equipname(get_shield)}"
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
  def get_character
    f = File.open('c.json', 'r')
    config = JSON.load(f)
  end
  def get_experience
    @experience
  end
  def set_experience(exp)
    @experience = exp
  end
  def equipname(en)
    if en.to_s == "0"
      'None'
    else
      en
    end
  end
  def weaponname(wn)
    if wn.to_s == "0"
      'Fists'
    else
      wn
    end
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
    outfile.write ("        \"weapon\" : \"#{get_weapon}\",\n")
    outfile.write ("        \"armor\"  : \"#{get_armor}\",\n")
    outfile.write ("        \"shield\" : \"#{get_shield}\",\n")
    outfile.write ("        \"coin\" : #{get_money},\n")
    outfile.write ("        \"exp\" : #{get_experience},\n")
    outfile.write ("        \"inv\" : #{get_inventory}\n")
    outfile.write ("    }\n")
    outfile.write ("}\n")
    outfile.close
  end
end