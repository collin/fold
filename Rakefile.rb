require 'rubygems'
require 'pathname'
require 'spec'

__DIR__ = Pathname.new(__FILE__).dirname


task :default => 'spec:all'

namespace :spec do

  task :prepare do
    @specs= Dir.glob("#{__DIR__}/rspec/**/*.rb").join(' ')
  end

  task :all => :prepare do
    system "spec #{@specs}"
  end
  
  task :doc => :prepare do
    system "spec #{@specs} --format specdoc"
  end
end

task :cleanup do 
  Dir.glob("**/*.*~")+Dir.glob("**/*~").each{|swap|FileUtils.rm(swap, :force => true)}
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "fold"
    gemspec.summary = "A toolkit for creating whitespace active mini-languages. Inspired by Haml, light on features."
    # gemspec.description = "A different and possibly longer explanation of"
    gemspec.email = "collintmiller@gmail.com"
    gemspec.homepage = "http://github.com/collin/fold"
    gemspec.authors = ["Collin Miller"]

    gemspec.add_dependency('ruby2ruby', '1.2.4')
    gemspec.add_dependency('ParseTree', '3.0.4')    
    gemspec.add_dependency('metaid', '1.0')    
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end
