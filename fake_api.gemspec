$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "fake_api/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "fake_api"
  spec.version     = FakeApi::VERSION
  spec.authors     = ["Igor Kasyanchuk"]
  spec.email       = ["igorkasyanchuk@gmail.com"]
  spec.homepage    = "https://github.com/igorkasyanchuk/fake_api"
  spec.summary     = "Summary of FakeApi."
  spec.description = "Description of FakeApi."
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails"
  spec.add_dependency "faker"

  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "pry"
end
