#Imports
require 'json'
require_relative("character")

#Definitions
stores = ["Wonderful World of Weapons", "Amy's Armor", "Sharpfail's Shields", "House of Healing", "Petunia's Potions"]

#Functions
def temple(char)
  templeexit = -1
  while templeexit != 0
    system('cls')
    puts "Location: House of Healing"
    health_needs = char.get_maximum_hit_points - char.get_hit_points
    if health_needs % 2 == 0
      health_cost = health_needs / 2
    else
      health_cost = (health_needs + 1) / 2
    end
    if health_needs == 0
      templeexit = 0
      puts "You are way too healthy to be here. Go away!"
      puts "1. Go Away"
      choice = gets.chomp.to_i
      system('cls')
    elsif char.get_money > health_cost
      puts "I can make you good as new for only #{health_cost} coin(s)"
      puts "1. Please fix"
      puts "2. Maybe later"
      choice = gets.chomp.to_i
      case choice
        when 1
          char.set_money(char.get_money - health_cost)
          char.set_hit_points(char.get_maximum_hit_points)
          char.save
        when 2
          templeexit = 0
      end
    elsif health_cost > char.get_money && char.get_money > 0
      puts "I'm not a miracle worker, but I can get you back #{char.get_money * 2} points of health back for only #{char.get_money} coin(s)"
      puts "1. Please fix"
      puts "2. Maybe later"
      choice = gets.chomp.to_i
      case choice
        when 1
          char.set_hit_points(char.get_hit_points + char.get_money * 2)
          char.set_money(0)
          char.save
        when 2
          templeexit = 0
      end
    elsif char.get_money == 0
      templeexit = 0
      puts "What are you expecting? Universal health care?. Go away!"
      puts "1. Go Away"
      choice = gets.chomp.to_i
      system('cls')
    end
  end
end

def shopping_mall(char)
  mallexit = -1
  while mallexit != 0
    puts "Welcome to the WD Shopping Mall"
    puts "1. Wonderful World of Weapons"
    puts "2. Amy's Armor"
    puts "3. Sharpfail's Shields"
    puts "4. Petunia's Potions"
    puts "5. Leave the Shopping Mall - back to the Crossroads"
    choice = gets.chomp.to_i
    case choice
      when 1
        storeexit = -1
		while storeexit != 0
		  system('cls')
          puts "Future Home of the Wonderful World of Weapons"
          puts "1. Leave Store"
          wstore_choice = gets.chomp.to_i
          case wstore_choice
            when 1
              system('cls')
              storeexit = 0
            end
          end
      when 2
        storeexit = -1
		while storeexit != 0
		  system('cls')
          puts "Future Home of Amy's Armor"
          puts "1. Leave Store"
          astore_choice = gets.chomp.to_i
          case astore_choice
            when 1
              system('cls')
              storeexit = 0
            end
          end
      when 3
        storeexit = -1
		while storeexit != 0
		  system('cls')
          puts "Future Home of Sharpfail's Shields"
          puts "1. Leave Store"
          sstore_choice = gets.chomp.to_i
          case sstore_choice
            when 1
              system('cls')
              storeexit = 0
            end
          end
      when 4
        storeexit = -1
        while storeexit != 0
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
              puts "4. Exit Menu"
              menu_option = gets.chomp.to_i
              case menu_option
                when 1
                  if char.get_money >= 5
                    char.set_money(char.get_money - 5)
                    char.add_inventory("Cure Light Wounds potion")
                    char.save
                  else
                    puts "You don't have enough for the Cure Light Wounds potion"
                    message = gets.chomp.to_i
                  end
                when 2
                  storeexit = 0
                when 3
                  storeexit = 0
              end
            when 2
              storeexit = 0
            when 3
              storeexit = 0
          end
        end
      when 5
        mallexit = 0
        system "cls"
      else
        system "cls"
        puts "--Please enter a valid option--"
    end
  end
end

def enter_shop(shop)
  
end

#Classes
class Shop
  @name = ""
  @products = []
  
  def set_name(name)
    @name = name
  end
  def get_name
    @name
  end
end