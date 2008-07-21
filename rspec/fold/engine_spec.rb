require 'rspec/fold_spec_helper'

describe Fold::Engine do
  before(:each) do
    @fixture = Pathname.new(FoldFixtureRoot)
    @path= @fixture +"fixture.target.fold"
    @engine= Fold::Engine.new @path.read  

#     @empty = @fixture + "empty.target.fold"
#     @empty_engine = Fold::Engine.new @empty.read
  end

  it "inherits Module" do
    Fold::Engine.class.should == Class
  end

  describe "#initialize" do
    it "sets fold content" do
      @engine.instance_variable_get(:@source).should == File.read(@path)
    end
  end
  
  describe "#lines" do
    it "splits on line breaks" do
      lines= 10
      src= "LINE\n" * lines
      en= Fold::Engine.new src
      en.lines.length.should == lines
    end
    
    it "rejects whitespace only lines" do
      src= "LINE\n   \nLINE\n\t\n\t\nwhatup?"
      en= Fold::Engine.new src
      en.lines.length.should == 3
    end
  end
  
  describe "#render" do
    it "renders spec" do
      Fold::Precompiler.folds :Line, //
      source= File.read "#{FoldFixtureRoot}/fixture.target.fold"
      en= Fold::Engine.new source
    end
  end
end