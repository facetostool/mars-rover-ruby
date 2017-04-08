require 'spec_helper'

RSpec.describe BECoding::RoversManager do

  it 'check everything works perfect' do
    plateau = BECoding::Plateau.new(BECoding::Point.new(5,5))

    rover0 = BECoding::Rover.new(plateau, BECoding::Point.new(1, 2), BECoding::Direction::Lookup.init_by_uppercase('N'))
    rover1 = BECoding::Rover.new(plateau, BECoding::Point.new(3, 3), BECoding::Direction::Lookup.init_by_uppercase('E'))

    manager = BECoding::RoversManager.new([rover0, rover1])
    manager.send_commands(0, 'LMLMLMLMM')
    manager.send_commands(1, 'MMRMMRMRRM')

    expect(rover0.current_location).to eq('1 3 N')
    expect(rover1.current_location).to eq('5 1 E')
  end

end