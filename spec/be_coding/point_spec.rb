require 'spec_helper'

RSpec.describe BECoding::Point do

  let(:x) { 0 }
  let(:y) { 0 }

  let(:point) { BECoding::Point.new(x, y) }

  subject { point }

  it { should respond_to(:x) }
  it { should respond_to(:y) }
  it { should respond_to(:x=) }
  it { should respond_to(:y=) }

end