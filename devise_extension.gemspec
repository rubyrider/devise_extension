$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "devise_extension/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "devise_extension"
  s.version     = DeviseExtension::VERSION
  s.authors     = ["Irfan Ahmed"]
  s.email       = ["irfandhk@gmail.com"]
  s.homepage    = "https://github.com/rubyrider/devise_extension"
  s.summary     = "An extension for devise engine"
  s.description = "This engine contains extension for devise. Initially it provides security question answer module."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.5"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "byebug"
  s.add_development_dependency 'minitest-reporters'
  s.add_runtime_dependency 'railties', '>= 4.0.0'
  s.add_runtime_dependency 'devise', '>= 4.0.0'
end
