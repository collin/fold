__DIR__ = File.dirname(__FILE__)
$LOAD_PATH << __DIR__ unless $LOAD_PATH.include?(__DIR__)

require 'facets'

module Fold
  require 'fold/engine'
  require 'fold/abstract_fold'
  require 'fold/abstract_slice'
  require 'fold/fold_factory'
  require 'fold/slice_factory'
  require 'fold/precompiler'
end