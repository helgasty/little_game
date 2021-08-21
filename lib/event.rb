class Event
  TYPES = [:potion, :sword, :trap, :converter]

  attr_accessor :type

  def initialize
    @type = TYPES.sample
  end

  def dialog
    "Your front of a box room, do you want open-it ? (yes/no)"
  end

  def interact(player)
    case @type
    when :potion
      player.heal(10)
      puts "You pick up #{@type}, heal you for 10 HP."
    when :sword
      player.power += 1
      puts "You pick up #{@type}, power up to #{player.power}."
    when :trap
      player.hit(10)
      puts "You fall in a #{@type}, you lost 10 HP."
    when :converter
      puts "You find \"the converter\", a ancestral item who convert HP to POWER, you'r convert 20 HP to 5 POWER."
      if player.life > 20
        player.hit(20)
        player.power += 5
      else
        puts "Not enough life"
      end
    end

    puts player.status
  end
end
