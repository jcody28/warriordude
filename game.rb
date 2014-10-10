class Game
  def initialize
    puts "1. New Game"
    puts "2. Continue Game"
    newgame = gets.chomp.to_i
  end
  def run
    exit = false
    while !exit
      puts "Location: Crossroads"
      puts "a sign reads:"
      puts "1. Dungeon"
      puts "2. Store"
      puts "3. End Game"
      choice = gets.chomp.to_i
      case choice
        when 1
          puts "Dungeon code goes here."
        when 2
          puts "Store code goes here."
        when 3
          puts "See you later!"
          exit = true
        else
          puts "Please enter a given option"
      end
    end
  end
end