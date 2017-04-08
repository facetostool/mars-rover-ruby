require 'spec_helper'

RSpec.describe BECoding::Rover do

  let(:direction_class) { BECoding::Direction::North }
  let(:direction) { direction_class.new }
  let(:position_x) { 3 }
  let(:position_y) { 3 }
  let(:max_x) { 5 }
  let(:max_y) { 5 }
  let(:plateau) { BECoding::Plateau.new(BECoding::Point.new(max_x, max_y)) }

  subject { BECoding::Rover.new(plateau, BECoding::Point.new(position_x, position_y), direction) }

  it { should respond_to(:plateau) }
  it { should_not respond_to(:plateau=) }
  it { should_not respond_to(:coordinates) }
  it { should_not respond_to(:coordinates=) }
  it { should respond_to(:direction) }
  it { should_not respond_to(:direction=) }

  describe 'check x' do
    it 'get' do
      expect(subject.x).to eq(position_x)
    end

    describe 'set' do
      it 'with valid' do
        new_x = 4
        subject.x = new_x
        expect(subject.x).to eq(new_x)
      end

      it 'with invalid' do
        expect{ subject.x = max_x + 1 }.to raise_error BECoding::Validators::LocationBounds::OutOfBoundsError
      end
    end
  end

  describe 'check y' do
    it 'get' do
      expect(subject.y).to eq(position_y)
    end

    describe 'set' do
      it 'with valid' do
        new_y = 4
        subject.y = new_y
        expect(subject.y).to eq(new_y)
      end

      it 'with invalid' do
        expect{ subject.y = max_y + 1 }.to raise_error BECoding::Validators::LocationBounds::OutOfBoundsError
      end
    end
  end

  it 'check not valid coordinates initialization should raise error' do
    expect{ BECoding::Rover.new(plateau, BECoding::Point.new(6,6), direction) }.
        to raise_error(BECoding::Validators::LocationBounds::OutOfBoundsError)
  end

  it 'check execute commands works correctly' do
    subject.execute_command(BECoding::Command::Left.new)
    expect(subject.direction.class).to eq(BECoding::Direction::West)
  end

  it 'check spin_left works correctly' do
    subject.spin_left
    expect(subject.direction.class).to eq(BECoding::Direction::West)
    expect(subject.x).to eq(position_x)
    expect(subject.y).to eq(position_y)
  end

  it 'check spin_right works correctly' do
    subject.spin_right
    expect(subject.direction.class).to eq(BECoding::Direction::East)
    expect(subject.x).to eq(position_x)
    expect(subject.y).to eq(position_y)
  end

  it 'check move works correctly' do
    subject.move
    expect(subject.direction.class).to eq(BECoding::Direction::North)
    expect(subject.x).to eq(position_x)
    expect(subject.y).to eq(position_y + 1)
  end

  it 'check move to far raises error' do
    subject.move
    subject.move
    expect{subject.move}.to raise_error(BECoding::Validators::LocationBounds::OutOfBoundsError)
  end

  it 'check current_location works correctly' do
    expect(subject.current_location).
        to eq("#{position_x} #{position_y} #{BECoding::Direction::Lookup::DIRECTIONS.key(direction_class).to_s}")
  end

  it 'check current_location works correctly' do
    expect(subject.current_location).
        to eq("#{position_x} #{position_y} #{BECoding::Direction::Lookup::DIRECTIONS.key(direction_class).to_s}")
  end

end