module BECoding::Direction
  class South
    def spin_right
      West.new
    end

    def spin_left
      East.new
    end

    def move(rover)
      rover.y -= 1
      self
    end
  end
end