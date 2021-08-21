class Monster
  attr_accessor :life, :power, :name

  MONSTERS = %w{ zombie ghost goul vampire troll skeleton werewolf dragon demon }

  def initialize(args = {})
    @is_boss = args[:is_boss]
    @life = (@is_boss) ? 30 : 10
    @name = (@is_boss) ? 'Cthulhu' : MONSTERS.sample
    @power = (@is_boss) ? 8 : 3
  end

  def alive?
    @life > 0
  end

  def hit(damage)
	  @life -= damage
  end	

  def dialog
    (@is_boss) ? "Cthulhu is waiting for you, this is the final fight !" : "A #{@name} attack you ! What do you do ? (fight/run)"
  end

  def interact(player)

    puts dialog

    while player.alive?
      monster_power = (1..@power).to_a.sample
      player_power = (1..player.power).to_a.sample
      puts "You hit the monster for #{player_power} HP !"
      hit(player_power)

      if !alive? && @is_boss
        abort "Cthulhu is dead, congrats ! =D" 
      elsif !alive?
        puts "#{@name} defeat :)"
        break
      end

      player.hit(monster_power)
      puts "The monster hit you -> you loose #{monster_power} HP !"
    end
  end
end