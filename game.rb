#Imports
require 'json'
require_relative("character")
require_relative("monster")
require_relative("shop")


#Classes
class Game
  def initialize
    puts "1. New Game"
    puts "2. Continue Game"
    newgame = gets.chomp.to_i
    case newgame
      when 1
        createchar  # moved from being defined here to character.rb
    end
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
	  puts "3. Temple"
      puts "4. Stats"
      puts "5. End Game"
      choice = gets.chomp.to_i
      case choice
        when 1
          system "cls"
          puts "Location: The Dungeon"
          dungeon(char)
        when 2
          system "cls"
          shopping_mall(char)
        when 3
          system "cls"
          temple(char)
        when 4
          system "cls"
          char.display
        when 5
          puts "See you later!"
          char.save
          exit = true
        else
          system "cls"
          puts "--Please enter a valid option--"
      end
    end
  end
end