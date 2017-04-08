class BECoding::Validators::LocationBounds
  def initialize(min_limits, max_limits)
    @max_limits = max_limits
    @min_limits = min_limits
  end

  def validate(rover)
    return if rover.x <= @max_limits.x &&
        @min_limits.x <= rover.x &&
        rover.y <= @max_limits.y &&
        @min_limits.y <= rover.y
    raise OutOfBoundsError.new, 'You are out of limit bounds'
  end

  class OutOfBoundsError < StandardError ; end
end