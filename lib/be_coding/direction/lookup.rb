module BECoding::Direction::Lookup
  DIRECTIONS = {
      E: BECoding::Direction::East,
      W: BECoding::Direction::West,
      N: BECoding::Direction::North,
      S: BECoding::Direction::South
  }

  def self.init_by_uppercase(uppercase)
    raise NoDirectionFoundError.new, "No direction found by uppercase: #{uppercase}" unless DIRECTIONS.has_key? uppercase.to_sym
    DIRECTIONS[uppercase.to_sym].new
  end

  class NoDirectionFoundError < StandardError ; end
end