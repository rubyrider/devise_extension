$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "devise_extension/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "devise_extension"
  s.version     = DeviseExtension::VERSION
  s.authors     = ["Irfan"]
  s.email       = ["irfandhk@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of DeviseExtension."
  s.description = "TODO: Description of DeviseExtension."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.5"

  s.add_development_dependency "sqlite3"
end
