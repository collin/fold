require 'rubygems'
require 'spec'

namespace :spec do
  task :prepare do
    path = File.dirname(__FILE__)
    p path
    @specs= Dir.glob("#{path}/rspec/**/*.rb").join(' ')
  end

  task :all => :prepare do
    system "spec #{@specs}"
  end
  
  task :doc => :prepare do
    system "spec #{@specs} --format specdoc"
  end
end