require 'pathname'
require 'activesupport'
require 'parse_tree'
require 'parse_tree_extensions'
require 'ruby2ruby'
require 'metaid'

module Fold
  def self.root
    @root ||= Pathname.new(__FILE__).dirname.expand_path
  end
  require root+'fold/engine'
  require root+'fold/abstract_fold'
  require root+'fold/abstract_slice'
  require root+'fold/fold_factory'
  require root+'fold/slice_factory'
  require root+'fold/precompiler'
end