# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "heroku_env/version"

Gem::Specification.new do |s|
  s.name        = "heroku_env"
  s.version     = HerokuEnv::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Daniel Spangenberg"]
  s.email       = ["daniel.spangenberg@parcydo.com"]
  s.homepage    = "http://neonlex.github.com"
  s.summary     = %q{With this gem you can develop with environment variables local like you would do on heroku.}
  s.description = %q{This gem provides heroku environment variables in your local development environment.}

  s.add_dependency "heroku"

  s.rubyforge_project = "heroku_env"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
