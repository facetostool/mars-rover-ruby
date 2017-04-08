module BECoding::Direction
  class North
    def spin_right
      East.new
    end

    def spin_left
      West.new
    end

    def move(rover)
      rover.y += 1
      self
    end
  end
end