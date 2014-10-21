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
    character.save
    character.display
  end

  def dungeon(char)
    exitdungeon = -1
    bad_guy = Monster.new
    loadmonster(bad_guy, char)
    while exitdungeon != 0
	  puts "Your character is level: #{char.get_level.to_s}"
      puts "You face a level #{bad_guy.get_level.to_s} #{bad_guy.get_name}!"
      puts "Just be sure to dodge it's #{bad_guy.get_weapon}!"
      puts "HP:  #{bad_guy.get_hit_points.to_s} of #{bad_guy.get_maximum_hit_points.to_s}"
      puts "It may have #{bad_guy.get_money.to_s} coin(s) if you kill it!"
      exitdungeon = 0
    end
  end
  
  def get_monster
    f = File.open('m.json', 'r')
    config = JSON.load(f)
  end
  
  def rolldie(sides)
	rand(sides) + 1
  end
  
  def rolldice(num, sides, mod)
	i = 0
	result = 0
	while i < num do
	  result = result + rolldie(sides)
	  i +=1
	end
	result + mod
  end
  
  def loadmonster(mon, char)
    randomlevel = rand(10)+1
    case
      when randomlevel < 8
        mon.set_level(char.get_level)
      when randomlevel > 7 && randomlevel < 10
		if char.get_level == 1
		  mon.set_level(1)
		else
		  mon.set_level(char.get_level - 1)
		end
      when randomlevel == 10
        mon.set_level(char.get_level + 1)
    end
    mr = rand(9)+1
	dr = rand(14)+1 # there has to be a better way to limit some descriptors based on which monster was randomized - TBD
    monhp = rolldice(mon.get_level, 10, 0) # wanted to give d10 hp for each monster level - we can change this
	#  Coin for the monster should be the max coin possible for killing it as we discussed - we have to decide how to dole out
	#    a percentage of the max based on how difficult the battle was and the level difference should be included too.
    moncoin = rolldice(mon.get_level, 12, 0) # wanted to give d12 potential coins per monster level - we can change this
    mon.set_maximum_hit_points(monhp)
    mon.set_hit_points(monhp)
    mon.set_money(moncoin)
    mon.set_name(get_monster['descriptor'][dr.to_s] + ' ' + get_monster['monster'][mr.to_s])
    mon.set_weapon(get_monster['weapon'][mr.to_s])
  end

  def run
    exit = false
    char = Character.new
    char.loadchar
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
          char.display
        when 4
          puts "See you later!"
		  char.save
          exit = true
        else
          puts "Please enter a given option"
      end
    end
  end

  def shopping(char)
    shopexit = -1
    while shopexit != 0
      puts "1. Wonderful World of Weapons"
      puts "2. Amy's Armor"
      puts "3. Sharpfail's Shields"
      puts "4. House of Healing"
	  puts "5. Petunia's Potions"
      puts "6. Back to the Crossroads"
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
              puts'You are way too healthy to be here. Go away!'
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
                  char.save
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
                  char.save
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
		  healexit = -1
          while healexit != 0
            system('cls')
            puts "Location: Petunia's Potions"
			puts "1. See Menu"
			puts "2. Sell from Inventory"  # TBD
			puts "3. Leave Store"
			choice = gets.chomp.to_i
            case choice
			  when 1
			    system('cls')
				puts "Petunia's Potions Menu"
				puts "1. Cure Light Wonds (5 coins)"
				puts "2. Cure Moderate Wonds (20 coins)"
				puts "3. Cure Serious Wonds (50 coins)"
				menu_option = gets.chomp.to_i
				case 
				char.set_hit_points(char.get_hit_points + char.get_money * 2)
				char.set_money(0)
				char.save
			  when 2
				healexit = 0
              when 3
                healexit = 0
            end
        when 6
          shopexit = 0
          system("cls")
        else
          system('cls')
      end
    end
  end
end