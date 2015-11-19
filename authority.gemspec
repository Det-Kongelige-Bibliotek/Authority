$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "authority/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "authority"
  s.version     = Authority::VERSION
  s.authors     = ["David Grove Jørgensen"]
  s.email       = ["dgj@kb.dk"]
  s.homepage    = "https://github.com/Det-Kongelige-Bibliotek/authority"
  s.summary     = "Rails engine for authorities in Hydra"
  s.description = "Rails engine for authorities in Hydra"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5"
  s.add_dependency "hydra"

  s.add_development_dependency "sqlite3"
end
