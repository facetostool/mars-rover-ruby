module BECoding::Direction
  class West
    def spin_right
      North.new
    end

    def spin_left
      South.new
    end

    def move(rover)
      rover.x -= 1
      self
    end
  end
end