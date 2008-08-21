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

namespace :gem do
  task :version do
    @version = "0.0.9"
  end

  task :build => :spec do
    load __DIR__ + "fold.gemspec"
    Gem::Builder.new(@fold_gemspec).build
  end

  task :install => :build do
    cmd = "gem install fold -l"
    system cmd unless system "sudo #{cmd}"
    FileUtils.rm(__DIR__ + "fold-#{@version}.gem")
  end

  task :spec => :version do
    file = File.new(__DIR__ + "fold.gemspec", 'w+')
    FileUtils.chmod 0755, __DIR__ + "fold.gemspec"
    spec = %{
Gem::Specification.new do |s|
  s.name             = "fold"
  s.date             = "2008-07-21"
  s.version          = "#{@version}"
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.has_rdoc         = false
  s.summary          = "Toolkit for creating whitespace active mini-languages. Inspired by Haml. Feature light."
  s.authors          = ["Collin Miller"]
  s.email            = "collintmiller@gmail.com"
  s.homepage         = "http://github.com/collin/fold"
  s.files            = %w{#{(%w(README Rakefile.rb) + Dir.glob("{lib,rspec}/**/*")).join(' ')}}
  
  s.add_dependency  "rake"
  s.add_dependency  "rspec"
end
}

  @fold_gemspec = eval(spec)
  file.write(spec)
  end
end