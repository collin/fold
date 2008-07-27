require "ostruct"
require 'rspec/fold_spec_helper'

describe Fold::AbstracSlice do
  it "inherits OpenStruct" do
    Fold::AbstractSlice.superclass.should == OpenStruct
  end
end