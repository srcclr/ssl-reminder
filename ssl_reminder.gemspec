$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ssl_reminder/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ssl_reminder"
  s.version     = SslReminder::VERSION
  s.authors     = ["SRC:CLR"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "srcclr.com"
  s.summary     = "SSL Reminder"
  s.description = "SSL Reminder tool reminds of the upcoming expiry of SSL certificates"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.1"
  s.add_dependency "faraday", "~> 0.9.1"
  s.add_dependency "faraday_middleware", "~> 0.9.0"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "rspec-its"
  s.add_development_dependency "byebug"
  s.add_development_dependency "pry-byebug"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "pg"
  s.add_development_dependency "rubocop"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "ffaker"
end
