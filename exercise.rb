require 'logger'

module BECoding

  HEADINGS = {
    north:  'N',
    west:   'W',
    east:   'E',
    south:  'S'
  }

  DIRECTIONS = {
    move:   'M',
    left:   'L',
    right:  'R'
  }

  class Point
    attr_accessor :x, :y

    def initialize(x, y)
      @x, @y = x, y
    end
  end

  class Plateau

    def initialize(max_limits, min_limits = Point.new(0, 0), logger = Logger.new(STDOUT))
      @max_limits = max_limits
      @min_limits = min_limits
      @logger = logger
    end

    def check_limits(coordinates)
      coordinates.x <= @max_limits.x &&
        @min_limits.x <= coordinates.x &&
        coordinates.y <= @max_limits.y &&
        @min_limits.y <= coordinates.y
    end

  end

  module HeadingChecker
    def available_heading?(state)
      HEADINGS.keys.include? state
    end
  end

  module DirectionChecker
    def available_direction?(direction)
      DIRECTIONS.keys.include? direction
    end
  end

  class Rover

    include HeadingChecker

    attr_accessor :state

    attr_reader :plateau, :coordinates

    def initialize(point, heading, plateau, logger = Logger.new(STDOUT))
      @coordinates = point
      @plateau = plateau
      @logger = logger
      @state = define_state(heading)
    end

    def goto(goto)
      @state.goto(goto)
    end

    def position
      @state.position
    end

    def define_state(state)
      return Object.const_get("BECoding::States::HeadingState#{state.capitalize}").new(self) if available_heading?(state)
      @logger.warn "wrong state: #{state}"
      HeadingStateLost.new(self)
    end

  end

  module States

    module HeadingStatable
      def position
        raise NotImplementedError.new("You must implement #{__method__}.")
      end

      def to_s
        raise NotImplementedError.new("You must implement #{__method__}.")
      end

      def goto(direction)
        raise NotImplementedError.new("You must implement #{__method__}.")
      end
    end

    class HeadingState
      include HeadingStatable
      include DirectionChecker

      def initialize(rover, logger = Logger.new(STDOUT))
        @rover = rover
        @logger = logger
      end

      def position
        [@rover.coordinates.x, @rover.coordinates.y, self.to_s]
      end
    end

    class HeadingStateNorth < HeadingState

      def goto(direction)
        return unless available_direction?(direction)
        case direction
        when :left
          @rover.state = HeadingStateWest.new(@rover)
        when :right
          @rover.state = HeadingStateEast.new(@rover)
        when :move
          @rover.coordinates.y += 1
          @rover.state = HeadingStateLost.new(@rover) unless @rover.plateau.check_limits(@rover.coordinates)
        end
      end

      def to_s
        BECoding::HEADINGS[:north]
      end
    end

    class HeadingStateSouth < HeadingState

      def goto(direction)
        return unless available_direction? direction
        case direction
        when :left
          @rover.state = HeadingStateEast.new(@rover)
        when :right
          @rover.state = HeadingStateWest.new(@rover)
        when :move
          @rover.coordinates.y -= 1
          @rover.state = HeadingStateLost.new(@rover) unless @rover.plateau.check_limits(@rover.coordinates)
        end
      end

      def to_s
        BECoding::HEADINGS[:south]
      end
    end

    class HeadingStateEast < HeadingState

      def goto(direction)
        return unless available_direction? direction
        case direction
        when :left
          @rover.state = HeadingStateNorth.new(@rover)
        when :right
          @rover.state = HeadingStateSouth.new(@rover)
        when :move
          @rover.coordinates.x += 1
          @rover.state = HeadingStateLost.new(@rover) unless @rover.plateau.check_limits(@rover.coordinates)
        end
      end

      def to_s
        BECoding::HEADINGS[:east]
      end
    end

    class HeadingStateWest < HeadingState

      def goto(direction)
        return unless available_direction? direction
        case direction
        when :left
          @rover.state = HeadingStateSouth.new(@rover)
        when :right
          @rover.state = HeadingStateNorth.new(@rover)
        when :move
          @rover.coordinates.x -= 1
          @rover.state = HeadingStateLost.new(@rover) unless @rover.plateau.check_limits(@rover.coordinates)
        end
      end

      def to_s
        BECoding::HEADINGS[:west]
      end
    end

    class HeadingStateLost < HeadingState
      def goto(direction)
        @logger.warn("You are lost your rover! It can't be moved!")
      end

      def to_s
        'Lost'
      end

      def position
        ['lost', 'lost', 'lost']
      end
    end
  end

  class RoversManager

    def initialize(rovers = [])
      @rovers = rovers
    end

    def add_rover(rover)
      @rovers << rover
    end

    def set_commands(rover_number, commands)
      commands.each_char do |direction|
        @rovers[rover_number].goto(BECoding::DIRECTIONS.key(direction))
      end
    end

    def current_position
      @rovers.each do |rover|
        puts "#{rover.position.join(" ")}"
      end
    end

  end
end

plateau = BECoding::Plateau.new(BECoding::Point.new(5,5))

rover0 = BECoding::Rover.new(BECoding::Point.new(1,2), BECoding::HEADINGS.key('N'), plateau)
rover1 = BECoding::Rover.new(BECoding::Point.new(3,3), BECoding::HEADINGS.key('E'), plateau)

manager = BECoding::RoversManager.new([rover0, rover1])
manager.set_commands(0, 'LMLMLMLMM')
manager.set_commands(1, 'MMRMMRMRRM')

#manager.current_position