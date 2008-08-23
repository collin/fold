require 'rubygems'
__DIR__ = File.dirname(__FILE__)
$LOAD_PATH << "#{__DIR__}/.." unless $LOAD_PATH.include?("#{__DIR__}/..")
FoldFixtureRoot= File.expand_path("#{__DIR__}/fixtures/fold")

require "lib/fold"
require 'pathname'
