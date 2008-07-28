require 'rspec/fold_spec_helper'

class Included
  include Fold::FoldFactory
  include Fold::SliceFactory

  slices :Interpolation, /#\{(.*?)\}/ do
    text
  end

  def initialize
    @instance_variable = []
  end

  def passed
    :passed
  end
end

describe Fold::SliceFactory do
  it "inherits module" do
    Fold::SliceFactory.class.should == Module
  end

  before(:each) do
    @it = Included.new
  end

  it "has list of included slices" do
    Included.defined_slices.should include(Included::Interpolation)
  end

  it "generates constant" do
    Included::Interpolation.should_not be_nil
  end

  it "replaces items in a string" do
    @it.process('#{hey} whats #{up}').should == "hey whats up"
  end
end
