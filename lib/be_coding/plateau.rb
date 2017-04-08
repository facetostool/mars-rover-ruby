module BECoding
  class Plateau

    attr_reader :left_bottom_coord, :right_top_coord

    def initialize(right_top_coord, left_bottom_coord = Point.new(0, 0))
      @left_bottom_coord = left_bottom_coord
      @right_top_coord = right_top_coord
    end

  end
end