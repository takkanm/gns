# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gns/version'

Gem::Specification.new do |gem|
  gem.name          = "gns"
  gem.version       = Gns::VERSION
  gem.authors       = ["Mitsutaka Mimura"]
  gem.email         = ["takkanm@gmail.com"]
  gem.description   = %q{GitHub personalized feed Notifications Service}
  gem.summary       = %q{GitHub personalized feed Notifications Service}
  gem.homepage      = "https://github.com/takkanm/gns"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency 'foreverb'
  gem.add_dependency 'httpclient'
  gem.add_dependency 'terminal-notifier'
end
