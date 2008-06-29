Gem::Specification.new do |s|
  s.name             = "fold"
  s.version          = "0.0.1"
  s.platform         = Gem::Platform::RUBY
  s.has_rdoc         = false
  s.summary          = "   A toolkit for creating whitespace active mini-languages. Inspired by Haml, light on features."
  s.description      = s.summary
  s.author           = "Collin Miller"
  s.email            = "collintmiller@gmail.com"
  s.homepage         = "http://github.com/collin/fold"
  s.require_path     = "lib"
  s.files            = %w(README Rakefile.rb) + Dir.glob("{lib,rspec}/**/*")
  
  s.add_dependency  "rake"
  s.add_dependency  "rspec"
end