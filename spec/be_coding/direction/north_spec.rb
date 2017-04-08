require 'spec_helper'

RSpec.describe BECoding::Direction::North do
  it { should respond_to(:spin_left).with(0).argument }
  it { should respond_to(:spin_right).with(0).argument }
  it { should respond_to(:move).with(1).argument }

  it 'should return West after spin_left' do
    expect(subject.spin_left.class).to eq(BECoding::Direction::West)
  end

  it 'should return East after spin_right' do
    expect(subject.spin_right.class).to eq(BECoding::Direction::East)
  end

  it 'should move rover by y' do
    rover = BECoding::Rover.new(
        BECoding::Plateau.new(BECoding::Point.new(5,5)),
        BECoding::Point.new(3,3),
        BECoding::Direction::North.new
    )
    subject.move(rover)
    expect(rover.y).to eq(4)
    expect(rover.x).to eq(3)
  end
end