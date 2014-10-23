#Imports
require_relative("entity")


#Non Class Methods
def get_monster
  f = File.open('m.json', 'r')
  config = JSON.load(f)
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

#Classes
class Monster < Entity
end