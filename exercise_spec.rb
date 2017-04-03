require 'rspec'
require_relative 'exercise'

describe 'becoding exercise' do

  X_POINT = 3
  Y_POINT = 3

  let(:plateau) { BECoding::Plateau.new(BECoding::Point.new(5,5)) }

  describe 'Plateau' do

    describe 'check limits' do

      it 'valid' do
        expect(plateau.check_limits(BECoding::Point.new(1,2))).to eq(true)
      end

      it 'invalid' do
        expect(plateau.check_limits(BECoding::Point.new(6,5))).to eq(false)
      end

    end

  end

  describe 'DirectionChecker' do

    describe 'available_direction?' do

      before :each do
        @object = Object.new
        @object.extend(BECoding::DirectionChecker)
      end

      it 'valid' do
        expect(@object.available_direction?(BECoding::DIRECTIONS.keys.sample)).to eq(true)
      end

      it 'invalid' do
        expect(@object.available_direction?(:top)).to eq(false)
      end

    end

  end

  describe 'HeadingChecker' do

    describe 'available_heading?' do

      before :each do
        @object = Object.new
        @object.extend(BECoding::HeadingChecker)
      end

      it 'valid' do
        expect(@object.available_heading?(BECoding::HEADINGS.keys.sample)).to eq(true)
      end

      it 'invalid' do
        expect(@object.available_heading?(:another)).to eq(false)
      end

    end

  end

  describe 'Rover' do

    let(:rover) { BECoding::Rover.new(BECoding::Point.new(3,3), BECoding::HEADINGS.keys.sample, plateau) }

    describe 'define state' do

      BECoding::HEADINGS.keys.each do |heading|
        it "define state by #{heading}" do
          rover.define_state(heading)
          rover.state.class.to_s == "HeadingState#{heading.capitalize}"
        end
      end

    end

    it 'coordinates' do
      expect(rover.coordinates.x).to be(X_POINT)
      expect(rover.coordinates.y).to be(Y_POINT)
    end

    it 'goto' do
      previous = rover.state.to_s
      rover.goto(BECoding::DIRECTIONS.key('L'))
      expect(rover.state.to_s).to_not eq(previous)
    end

    it 'position' do
      expect(rover.position).to eq([X_POINT, Y_POINT, rover.state.to_s])
    end
  end

  describe 'States' do

    before :each do
      @rover = BECoding::Rover.new(BECoding::Point.new(X_POINT, Y_POINT), BECoding::HEADINGS.keys.first, plateau)
    end

    describe 'HeadingStateNorth' do

      let(:state) { BECoding::States::HeadingStateNorth.new(@rover) }

      before :each do
        @rover.state = state
      end

      describe 'goto' do

        it 'left' do
          coord_before = @rover.coordinates.clone
          state.goto(:left)
          expect(@rover.coordinates.x).to eq(coord_before.x)
          expect(@rover.coordinates.y).to eq(coord_before.y)
          expect(@rover.state.class).to eq(BECoding::States::HeadingStateWest)
        end

        it 'right' do
          coord_before = @rover.coordinates.clone
          state.goto(:right)
          expect(@rover.coordinates.x).to eq(coord_before.x)
          expect(@rover.coordinates.y).to eq(coord_before.y)
          expect(@rover.state.class).to eq(BECoding::States::HeadingStateEast)
        end

        it 'move' do
          coord_before = @rover.coordinates.clone
          state.goto(:move)
          expect(@rover.coordinates.x).to eq(coord_before.x)
          expect(@rover.coordinates.y).to eq(coord_before.y + 1)
          expect(@rover.state.class).to eq(BECoding::States::HeadingStateNorth)
        end

      end

      it 'position' do
        expect(state.position).to eq([X_POINT, Y_POINT, state.to_s])
      end

      it 'to_s' do
        expect(state.to_s).to eq(BECoding::HEADINGS[:north])
      end

    end

    describe 'HeadingStateSouth' do

      let(:state) { BECoding::States::HeadingStateSouth.new(@rover) }

      before :each do
        @rover.state = state
      end

      describe 'goto' do

        it 'left' do
          coord_before = @rover.coordinates.clone
          state.goto(:left)
          expect(@rover.coordinates.x).to eq(coord_before.x)
          expect(@rover.coordinates.y).to eq(coord_before.y)
          expect(@rover.state.class).to eq(BECoding::States::HeadingStateEast)
        end

        it 'right' do
          coord_before = @rover.coordinates.clone
          state.goto(:right)
          expect(@rover.coordinates.x).to eq(coord_before.x)
          expect(@rover.coordinates.y).to eq(coord_before.y)
          expect(@rover.state.class).to eq(BECoding::States::HeadingStateWest)
        end

        it 'move' do
          coord_before = @rover.coordinates.clone
          state.goto(:move)
          expect(@rover.coordinates.x).to eq(coord_before.x)
          expect(@rover.coordinates.y).to eq(coord_before.y - 1)
          expect(@rover.state.class).to eq(BECoding::States::HeadingStateSouth)
        end

      end

      it 'position' do
        expect(state.position).to eq([X_POINT, Y_POINT, state.to_s])
      end

      it 'to_s' do
        expect(state.to_s).to eq(BECoding::HEADINGS[:south])
      end

    end

    describe 'HeadingStateEast' do

      let(:state) { BECoding::States::HeadingStateEast.new(@rover) }

      before :each do
        @rover.state = state
      end

      describe 'goto' do

        it 'left' do
          coord_before = @rover.coordinates.clone
          state.goto(:left)
          expect(@rover.coordinates.x).to eq(coord_before.x)
          expect(@rover.coordinates.y).to eq(coord_before.y)
          expect(@rover.state.class).to eq(BECoding::States::HeadingStateNorth)
        end

        it 'right' do
          coord_before = @rover.coordinates.clone
          state.goto(:right)
          expect(@rover.coordinates.x).to eq(coord_before.x)
          expect(@rover.coordinates.y).to eq(coord_before.y)
          expect(@rover.state.class).to eq(BECoding::States::HeadingStateSouth)
        end

        it 'move' do
          coord_before = @rover.coordinates.clone
          state.goto(:move)
          expect(@rover.coordinates.x).to eq(coord_before.x + 1)
          expect(@rover.coordinates.y).to eq(coord_before.y)
          expect(@rover.state.class).to eq(BECoding::States::HeadingStateEast)
        end

      end

      it 'position' do
        expect(state.position).to eq([X_POINT, Y_POINT, state.to_s])
      end

      it 'to_s' do
        expect(state.to_s).to eq(BECoding::HEADINGS[:east])
      end

    end

    describe 'HeadingStateWest' do

      let(:state) { BECoding::States::HeadingStateWest.new(@rover) }

      before :each do
        @rover.state = state
      end

      describe 'goto' do

        it 'left' do
          coord_before = @rover.coordinates.clone
          state.goto(:left)
          expect(@rover.coordinates.x).to eq(coord_before.x)
          expect(@rover.coordinates.y).to eq(coord_before.y)
          expect(@rover.state.class).to eq(BECoding::States::HeadingStateSouth)
        end

        it 'right' do
          coord_before = @rover.coordinates.clone
          state.goto(:right)
          expect(@rover.coordinates.x).to eq(coord_before.x)
          expect(@rover.coordinates.y).to eq(coord_before.y)
          expect(@rover.state.class).to eq(BECoding::States::HeadingStateNorth)
        end

        it 'move' do
          coord_before = @rover.coordinates.clone
          state.goto(:move)
          expect(@rover.coordinates.x).to eq(coord_before.x - 1)
          expect(@rover.coordinates.y).to eq(coord_before.y)
          expect(@rover.state.class).to eq(BECoding::States::HeadingStateWest)
        end

      end

      it 'position' do
        expect(state.position).to eq([X_POINT, Y_POINT, state.to_s])
      end

      it 'to_s' do
        expect(state.to_s).to eq(BECoding::HEADINGS[:west])
      end

    end

    describe 'HeadingStateLost' do

      let(:state) { BECoding::States::HeadingStateLost.new(@rover) }

      before :each do
        @rover.state = state
      end

      describe 'goto' do

        it 'left' do
          state.goto(:left)
          expect(@rover.state.class).to eq(BECoding::States::HeadingStateLost)
        end

        it 'right' do
          state.goto(:right)
          expect(@rover.state.class).to eq(BECoding::States::HeadingStateLost)
        end

        it 'move' do
          state.goto(:move)
          expect(@rover.state.class).to eq(BECoding::States::HeadingStateLost)
        end

      end

      it 'position' do
        expect(state.position).to eq(['lost', 'lost', 'lost'])
      end

      it 'to_s' do
        expect(state.to_s).to eq('Lost')
      end

    end

  end

  describe 'RoversManager' do

    it "set commands" do
      plateau = BECoding::Plateau.new(BECoding::Point.new(5,5))

      rover0 = BECoding::Rover.new(BECoding::Point.new(1,2), BECoding::HEADINGS.key('N'), plateau)
      rover1 = BECoding::Rover.new(BECoding::Point.new(3,3), BECoding::HEADINGS.key('E'), plateau)

      manager = BECoding::RoversManager.new([rover0, rover1])
      manager.set_commands(0, 'LMLMLMLMM')
      manager.set_commands(1, 'MMRMMRMRRM')

      expect(rover0.position).to eq([1, 3, 'N'])
      expect(rover1.position).to eq([5, 1, 'E'])
    end

  end

end