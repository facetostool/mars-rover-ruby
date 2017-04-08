module BECoding::Direction
  class East
    def spin_right
      South.new
    end

    def spin_left
      North.new
    end

    def move(rover)
      rover.x += 1
      self
    end
  end
end