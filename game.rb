Dir["/var/www/livestorm_game/lib/*.rb"].each { |file| require_relative file }

class Game
  
  AVAILABLE_ACTIONS = { 
    fight: "fight the monster",
    run: "escape the fight (70% rate to failed and loose 5 HP)",
    heal: "use potion to restore 10 HP (start game with 2 potions)",
    help: "show available actions",
    exit: "leave the game",
    top: "a room direction",
    left: "a room direction",
    right: "a room direction",
    status: "show player informations",
    yes: "",
    no: ""
  }

  DIRECTIONS = [:left, :top, :right]
  FIRST_ROOM_NUMBER = 1

  def initialize(args)
    @player = Player.new(args)
    @room_number = FIRST_ROOM_NUMBER
    @room = generate_room

    play
  end

  private 
  def play
    require "readline"
    puts "Welcome #{@player.name} ! What's direction you want ? (left/top/right)"
    puts "(Use command \"help\" for more informations)"

    while input = Readline.readline('> ', true)
      abort "Exit!" if input.eql? 'exit'
      sym_action = input.to_sym
      do_action sym_action
    end
  end

  def do_action(action)
    if AVAILABLE_ACTIONS.include? action
      case action
      when :heal
        @player.use_potion
      when :help 
        puts "-" * 50
        AVAILABLE_ACTIONS.each{ |action, description| puts "-> #{action} : #{description}"}
        puts "-" * 50
      when :status
        @player.status
      when :fight
        puts @room.interact(@player)
        puts "What's direction you want ? (left/top/right)"
      when :run 
        if @room.type.class.eql? Event
          puts "Action invalid !" 
        else  
          if @player.run
            puts "You escaped the monster !", "What's direction you want ? (left/top/right)"
          else
            @player.hit(5)
            puts "Monster catch you -> you loose 5 HP !"
          end
        end
      when :yes  
        puts @room.interact(@player)
        puts "What's direction you want ? (left/top/right)"
      when :no
        puts "You doesn't open the box.", "What's direction you want ? (left/top/right)"
      when *DIRECTIONS
        @room = generate_room(action)
        @room_number += 1 
        puts @room.dialog, @room.details
      end
    else
      puts "Action invalid !" 
    end

    abort @player.dead unless @player.alive?
  end

  def generate_room(direction = "top")
    @room = Room.new({room_number: @room_number, direction: direction})
  end
end

puts "Hi adventurer, we challenge you to the rooms of the death !"
puts "You must survive to 10 rooms and defeat the boss : Cthulhu the destructor !!!"
puts "So, what's your name adventurer ?"
Game.new({player_name: gets.chomp})