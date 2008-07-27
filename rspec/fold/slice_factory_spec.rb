require 'rspec/fold_spec_helper'

class Included
  include Fold::FoldFactory
  include Fold::SliceFactory

  slices :Interpolation /#\{(.*?)\}/ do
    
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

  it "replaces items in a string" do
    @it.process_line "#{hey} whats #{up}"
  end
end
