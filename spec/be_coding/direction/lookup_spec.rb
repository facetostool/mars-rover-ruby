require 'spec_helper'

RSpec.describe BECoding::Direction::Lookup do

  subject { BECoding::Direction::Lookup }
  it { should respond_to(:init_by_uppercase).with(1).argument }

  describe 'init_by_uppercase' do

    BECoding::Direction::Lookup::DIRECTIONS.keys.each do |uppercase|
      it "no error by uppercase #{uppercase}" do
        expect{ BECoding::Direction::Lookup.init_by_uppercase(uppercase) }.to_not raise_error
      end

      it "creates new direction #{BECoding::Direction::Lookup::DIRECTIONS[uppercase.to_sym]}" do
        cmd = BECoding::Direction::Lookup.init_by_uppercase(uppercase)
        expect(cmd.class).to eq(BECoding::Direction::Lookup::DIRECTIONS[uppercase.to_sym])
      end
    end

    it 'raise error if wrong uppercase' do
      expect{ BECoding::Direction::Lookup.init_by_uppercase('Wrong') }.to raise_error(BECoding::Direction::Lookup::NoDirectionFoundError)
    end

  end

end