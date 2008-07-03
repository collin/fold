__DIR__ = path = File.dirname(__FILE__)

require 'rubygems'
require 'spec'

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

namespace :gem do
  task :spec do
    file = File.new("#{__DIR__}/fold.gemspec", 'w+')
    file.write %{
Gem::Specification.new do |s|
  s.name             = "fold"
  s.version          = "0.0.3"
  s.platform         = Gem::Platform::RUBY
  s.has_rdoc         = false
  s.summary          = "Toolkit for creating whitespace active mini-languages. Inspired by Haml. Feature light."
  s.description      = s.summary
  s.author           = "Collin Miller"
  s.email            = "collintmiller@gmail.com"
  s.homepage         = "http://github.com/collin/fold"
  s.require_path     = "lib"
  s.files            = %w{#{(%w(README Rakefile.rb) + Dir.glob("{lib,rspec}/**/*")).join(' ')}}
  
  s.add_dependency  "rake"
  s.add_dependency  "rspec"
end
}
  end
end