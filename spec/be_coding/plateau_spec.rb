require 'spec_helper'

RSpec.describe BECoding::Plateau do

  let(:x_min) { 0 }
  let(:x_max) { 0 }
  let(:y_min) { 5 }
  let(:y_max) { 5 }

  let(:plateau) { BECoding::Plateau.new(BECoding::Point.new(x_max, y_max), BECoding::Point.new(x_min, y_min)) }

  subject { plateau }

  it { should respond_to(:right_top_coord) }
  it { should respond_to(:left_bottom_coord) }
  it { should_not respond_to(:right_top_coord=) }
  it { should_not respond_to(:left_bottom_coord=) }

end