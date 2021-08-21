class Player

  attr_accessor :name, :life, :power, :potions
  MAX_LIFE = 100
  POTIONS = 2
  POWER = 3

  def initialize(args)
    @life = MAX_LIFE
    @potions = POTIONS
    @power = POWER
    @name = (args[:player_name].empty?) ? 'player' : args[:player_name]
  end

  def use_potion
    if @life.eql? MAX_LIFE
      puts "You have all life."
    elsif @potions > 0
      @potions -= 1
      self.heal(10)
      puts "Restore 10 HP."
    else    
      puts "No more potion."
    end
  end

  def run
    (1..100).to_a.sample <= 30
  end
    
  def alive?
    @life > 0
  end

  def dead
    "Sorry, you dead :("
  end

  def hit(damage)
    @life -= damage
  end	

  def heal(amount)
    @life += amount
    @life = 100 if @life > MAX_LIFE
  end

  def status
    puts "-" * 50
    puts "--- PLAYER NAME : #{@name} ---"
    puts "--- HP : #{@life} / #{MAX_LIFE} ---"
    puts "--- POWER : #{@power} ---"
    puts "-" * 50
  end
end