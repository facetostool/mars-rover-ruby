require 'spec_helper'

RSpec.describe BECoding::Command::Left do
  it { should respond_to(:execute).with(1).argument }
end