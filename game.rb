require_relative("character")
class Game
  def initialize
    puts "1. New Game"
    puts "2. Continue Game"
    newgame = gets.chomp.to_i
    case newgame
      when 1
        createchar
    end
  end

  def createchar
    puts "Enter your player's name."
    pn = gets.chomp
    character = Character.new
    character.set_name(pn)
    character.set_maximum_hit_points(10)
    character.set_hit_points(10)
    character.set_money(0)
    character.set_weapon(0)
    character.set_level(1)
    savechar(character)
    display_char(character)
  end

  def display_char(char)
    puts '****************'
    puts "Name:   #{char.get_name}"
    puts "HP:     #{char.get_hit_points} of #{char.get_maximum_hit_points}"
    puts "Level:  #{char.get_level}"
    puts "Weapon: #{char.weaponname(char.get_weapon)}"
    puts "Armor:  #{char.armorname(char.get_armor)}"
    puts "Shield: #{char.shieldname(char.get_shield)}"
    puts "Coin:   #{char.get_money}"
    puts "Exp:    #{char.get_experience}"
    puts '****************'
  end

  def run
    exit = false
    while !exit
      puts "Location: Crossroads"
      puts "a sign reads:"
      puts "1. Dungeon"
      puts "2. Store"
      puts "3. Stats"
      puts "4. End Game"
      choice = gets.chomp.to_i
      case choice
        when 1
          puts "Dungeon code goes here."
        when 2
          puts "Store code goes here."
        when 3
          display_char(character)
        when 4
          puts "See you later!"
          exit = true
        else
          puts "Please enter a given option"
      end
    end
  end

  def savechar(char)
    outfile = open('c.json', 'w')
    outfile.write ("{\n")
    outfile.write ("    \"character\" :\n")
    outfile.write ("    {\n")
    outfile.write ("        \"name\" : \"#{char.get_name}\",\n")
    outfile.write ("        \"mhp\" : \"#{char.get_maximum_hit_points}\",\n")
    outfile.write ("        \"hp\" : \"#{char.get_hit_points}\",\n")
    outfile.write ("        \"level\" : \"#{char.get_level}\",\n")
    outfile.write ("        \"weapon\" : \"#{char.get_weapon}\",\n")
    outfile.write ("        \"shield\" : \"#{char.get_shield}\",\n")
    outfile.write ("        \"coin\" : \"#{char.get_money}\",\n")
    outfile.write ("        \"exp\" : \"#{char.get_experience}\"\n")
    outfile.write ("    }\n")
    outfile.write ("}\n")
    outfile.close
  end
end