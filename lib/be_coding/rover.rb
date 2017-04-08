module BECoding
  class Rover

    attr_reader :plateau, :direction

    def initialize(plateau, coordinates, direction)
      @plateau = plateau
      @coordinates = coordinates
      @direction = direction
      @validators = [Validators::LocationBounds.new(@plateau.left_bottom_coord, @plateau.right_top_coord)]
      validate
    end

    def x=(x)
      @coordinates.x = x
      validate
    end

    def x
      @coordinates.x
    end

    def y=(y)
      @coordinates.y = y
      validate
    end

    def y
      @coordinates.y
    end

    def execute_command(command)
      command.execute(self)
    end

    def spin_right
      @direction = @direction.spin_right
      validate
    end

    def spin_left
      @direction = @direction.spin_left
      validate
    end

    def move
      @direction = @direction.move(self)
      validate
    end

    def current_location
      "#{@coordinates.x} #{@coordinates.y} #{BECoding::Direction::Lookup::DIRECTIONS.key(@direction.class).to_s}"
    end

    private

    def validate
      @validators.each do |validator|
        validator.validate(self)
      end
    end

  end
end