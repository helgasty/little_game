class Room
  attr_accessor :type

  ROOM_DIRECTION = {
    left: 0,
    top: 1,
    right: 2
  }

  LAST_ROOM_NUMBER = 10

  def initialize(args)
    @room_number = args[:room_number]
    @type = room_type(args[:direction], args[:room_number])
    @size = room_size
    @adjective = get_adjective
  end

  def interact(player)
    @type.interact(player)
  end

  def dialog
    "Room #{@room_number}, You are in a #{@size} room. It is #{@adjective}."
  end

  def details
    @type.dialog
  end 

  private
  def room_type(direction, room_number)
    return Monster.new({is_boss: true}) if room_number.eql? LAST_ROOM_NUMBER
    enum_direction = ROOM_DIRECTION[direction.to_sym]
    [Monster, Event, Monster].shuffle[enum_direction].new
  end

  def room_size
    %w(tiny small medium large impresive).sample
  end

  def get_adjective
    %w(pretty confortable terrible strange unconfortable).sample
  end
end