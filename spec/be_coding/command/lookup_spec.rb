require 'spec_helper'

RSpec.describe BECoding::Command::Lookup do

  subject { BECoding::Command::Lookup }
  it { should respond_to(:init_by_uppercase).with(1).argument }

  describe 'init_by_uppercase' do

    BECoding::Command::Lookup::COMMANDS.keys.each do |uppercase|
      it "no error by uppercase #{uppercase}" do
        expect{ BECoding::Command::Lookup.init_by_uppercase(uppercase) }.to_not raise_error
      end

      it "creates new command #{BECoding::Command::Lookup::COMMANDS[uppercase.to_sym]}" do
        cmd = BECoding::Command::Lookup.init_by_uppercase(uppercase)
        expect(cmd.class).to eq(BECoding::Command::Lookup::COMMANDS[uppercase.to_sym])
      end
    end

    it 'raise error if wrong uppercase' do
      expect{ BECoding::Command::Lookup.init_by_uppercase('Wrong') }.to raise_error(BECoding::Command::Lookup::NoCommandFoundError)
    end

  end

end