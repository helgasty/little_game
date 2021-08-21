Dir["/var/www/livestorm_game/lib/*.rb"].each { |file| require_relative file }

require 'securerandom'

PLAYER_NAME = SecureRandom.hex(10)
PLAYER_MAX_LIFE = 100
AMOUNT = 5

describe "player" do
  player = Player.new({player_name: PLAYER_NAME})

  it "init player" do
    expect(player.name).to eq PLAYER_NAME
    expect(player.life.to_i).to eq PLAYER_MAX_LIFE
    expect(player.power).to eq 3
    expect(player.potions).to eq 2
  end 

  it "hit player" do
    player.hit(AMOUNT) 
    expect(player.life).to be < PLAYER_MAX_LIFE
    expect(player.life).to eq (PLAYER_MAX_LIFE - AMOUNT).to_i
  end

  it "heal player" do
    player.heal(AMOUNT)
    expect(player.life).to eq PLAYER_MAX_LIFE
  end
  
  it "player is dead" do
    player.hit(PLAYER_MAX_LIFE)
    expect(player.alive?).to eq false
  end

  it "player is alive" do
    player.heal(PLAYER_MAX_LIFE)
    expect(player.alive?).to eq true
  end
end

describe "monster" do 
  monster = Monster.new

  it "init monster" do
    expect(monster.power).to eq 3
    expect(monster.life).to eq 10
    expect(monster.name).not_to eq 'Cthulhu'
  end 

  it "hit monster" do
    life = monster.life
    monster.hit(AMOUNT)
    expect(monster.life).to eq (life - AMOUNT)
  end

  it "monster is alive" do 
    expect(monster.life).to be > 0
    expect(monster.alive?).to be true
  end

  it "monster is dead" do
    monster.hit(AMOUNT)
    expect(monster.life).to eq 0
    expect(monster.alive?).to be false
  end

  it "init boss" do
    boss = Monster.new({is_boss: true})
    expect(boss.power).to eq 8
    expect(boss.life).to eq 30
    expect(boss.name).to eq 'Cthulhu'
  end
end

describe "event" do
  player = Player.new({player_name: PLAYER_NAME})
  default_power = player.power 

  event = Event.new
  it "check event dialog" do 
    expect(event.dialog.class).to eq String
  end

  it "check event potion" do
    player.hit(AMOUNT)
    event.type = :potion
    event.interact(player)
    expect(player.life).to eq PLAYER_MAX_LIFE
  end

  it "check event sword" do 
    event.type = :sword
    event.interact(player)
    expect(player.power).to be > default_power 
  end 

  it "check event trap" do 
    event.type = :trap
    event.interact(player)
    expect(player.life).to be < PLAYER_MAX_LIFE
  end

  it "check event converter" do
    event.type = :converter
    event.interact(player)
    expect(player.life).to be < PLAYER_MAX_LIFE
    expect(player.power).to be > default_power 
  end

  it "player fight monster" do
    player = Player.new({player_name: PLAYER_NAME})
    monster = Monster.new

    monster.interact(player)
    expect(player.life).to be < PLAYER_MAX_LIFE
    expect(monster.alive?).to be false 
  end
end

describe "room" do

  room = Room.new({room_number: 1, direction: 'top'})

  it "check init room" do 
    expect(room.type.class).to eq(Monster).or eq(Event)
  end

  it "check room dialog" do
    expect(room.dialog.class).to eq String
  end
end

