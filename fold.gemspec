
Gem::Specification.new do |s|
  s.name             = "fold"
  s.date             = "2008-07-21"
  s.version          = "0.0.7"
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.has_rdoc         = false
  s.summary          = "Toolkit for creating whitespace active mini-languages. Inspired by Haml. Feature light."
  s.authors          = ["Collin Miller"]
  s.email            = "collintmiller@gmail.com"
  s.homepage         = "http://github.com/collin/fold"
  s.files            = %w{README Rakefile.rb lib/fold.rb lib/fold lib/fold/engine.rb lib/fold/abstract_fold.rb lib/fold/fold_factory.rb lib/fold/precompiler.rb lib/fold/fold_factory.rb~ lib/fold.js lib/fold.js~ rspec/fixtures rspec/fixtures/fold rspec/fixtures/fold/fixture.target.fold rspec/fixtures/fold/empty.target.fold rspec/fold_spec.rb rspec/fold_spec_helper.rb rspec/fold rspec/fold/precompiler_spec.rb rspec/fold/fold_factory_spec.rb rspec/fold/engine_spec.rb rspec/fold/abstract_fold_spec.rb rspec/fold/fold_factory_spec.rb~}
  
  s.add_dependency  "rake"
  s.add_dependency  "rspec"
end
