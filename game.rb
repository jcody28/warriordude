require 'json'
require_relative("character")
require_relative("monster")
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

  def dungeon(char)
    exitdungeon = -1
    bad_guy = Monster.new
    loadmonster(bad_guy, char)
    while exitdungeon != 0
      puts "You face a level #{bad_guy.get_level.to_s} #{bad_guy.get_name}!"
      puts "#{bad_guy.get_hit_points.to_s} of #{bad_guy.get_maximum_hit_points.to_s}"
      puts "It has #{bad_guy.get_money.to_s} kill coin(s)!"
      puts "Just be sure to dodge it's #{bad_guy.get_weapon}!"
      exitdungeon = 0
    end
  end

  def get_character
    f = File.open('c.json', 'r')
    config = JSON.load(f)
  end

  def get_monster
    f = File.open('m.json', 'r')
    config = JSON.load(f)
  end

  def loadchar(char)
    char.set_name(get_character['character']['name'])
    char.set_maximum_hit_points(get_character['character']['mhp'])
    char.set_hit_points(get_character['character']['hp'])
    char.set_level(get_character['character']['level'])
    char.set_weapon(get_character['character']['weapon'])
    char.set_armor(get_character['character']['armor'])
    char.set_shield(get_character['character']['shield'])
    char.set_money(get_character['character']['coin'])
    char.set_experience(get_character['character']['exp'])
  end

  def loadmonster(mon, char)
    randomlevel = rand(10)+1
    case
      when randomlevel < 8
        mon.set_level(char.get_level)
      when randomlevel > 7 && randomlevel < 10
        mon.set_level(char.get_level - 1)
      when randomlevel == 10
        mon.set_level(char.get_level + 1)
    end
    mn = rand(3)+1
    monhp = rand((10)+1)*mon.get_level
    monmon = rand((10)+1)*mon.get_level
    mon.set_maximum_hit_points(monhp)
    mon.set_hit_points(monhp)
    mon.set_money(monmon)
    mon.set_name(get_monster['monster'][mn.to_s])
    mon.set_weapon(get_monster['weapon'][mn.to_s])
  end

  def run
    exit = false
    char = Character.new
    loadchar(char)
    system "cls"
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
          system "cls"
          puts "Location: The Dungeon"
          dungeon(char)
        when 2
          system "cls"
          puts "Location: WD Shopping Center"
          shopping(char)
        when 3
          system "cls"
          display_char(char)
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
    outfile.write ("        \"mhp\" : #{char.get_maximum_hit_points},\n")
    outfile.write ("        \"hp\" : #{char.get_hit_points},\n")
    outfile.write ("        \"level\" : #{char.get_level},\n")
    outfile.write ("        \"weapon\" : #{char.get_weapon},\n")
    outfile.write ("        \"armor\"  : #{char.get_armor},\n")
    outfile.write ("        \"shield\" : #{char.get_shield},\n")
    outfile.write ("        \"coin\" : #{char.get_money},\n")
    outfile.write ("        \"exp\" : #{char.get_experience}\n")
    outfile.write ("    }\n")
    outfile.write ("}\n")
    outfile.close
  end

  def shopping(char)
    shopexit = -1
    while shopexit != 0
      puts '1. Wonderful World of Weapons'
      puts "2. Amy's Armor"
      puts "3. Sharpfail's Shields"
      puts '4. House of Healing'
      puts '5. Back to the Crossroads'
      choice = gets.chomp.to_i
      case choice
        when 4
          healexit = -1
          while healexit != 0
            system('cls')
            puts "Location: House of Healing"
            health_needs = char.get_maximum_hit_points - char.get_hit_points
            if health_needs % 2 == 0
              health_cost = health_needs / 2
            else
              health_cost = (health_needs + 1) / 2
            end
            if health_needs == 0
              healexit = 0
              puts'You are way to healthy to be here. Go away!'
              puts'1. Go Away'
              choice = gets.chomp.to_i
              system('cls')
            elsif char.get_money > health_cost
              puts"I can make you good as new for only #{health_cost} coin(s)"
              puts'1. Please fix'
              puts'2. Maybe later'
              choice = gets.chomp.to_i
              case choice
                when 1
                  char.set_money(char.get_money - health_cost)
                  char.set_hit_points(char.get_maximum_hit_points)
                  savechar(char)
                when 2
                  healexit = 0
              end
            elsif health_cost > char.get_money && char.get_money > 0
              puts"I'm not a miracle worker, but I can get you back #{char.get_money * 2} points of health back for only #{char.get_money} coin(s)"
              puts'1. Please fix'
              puts'2. Maybe later'
              choice = gets.chomp.to_i
              case choice
                when 1
                  char.set_hit_points(char.get_hit_points + char.get_money * 2)
                  char.set_money(0)
                  savechar(char)
                when 2
                  healexit = 0
              end
            elsif char.get_money == 0
              healexit = 0
              puts'What are you expecting? Universal health care?. Go away!'
              puts'1. Go Away'
              choice = gets.chomp.to_i
              system('cls')
            end
          end
        when 5
          shopexit = 0
          system("cls")
        else
          system('cls')
      end
    end
  end
end
