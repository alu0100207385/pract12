# -*- encoding: utf-8 -*-
  lib = File.expand_path('../lib', __FILE__)
  $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
#   $:.push File.expand_path("../lib", __FILE__)
  
 require 'matrices/version'
#  require "./lib/version"
 
 Gem::Specification.new do |gem|
   gem.name          = "matrices"
   gem.version       = Matrices::VERSION
   gem.authors       = ["Mª Belen Armas Torres | Aaron Socas Gaspar"]
   gem.email         = ["alu0100696677@ull.edu.es | alu0100207385@ull.edu.es"]
   gem.description   = %q{Permite representar y realizar operaciones con matrices densas y dispersas}
   gem.summary       = %q{Creación de matrices}
   gem.homepage      = "https://github.com/alu0100207385/pract10.git"

#  gem.rubyforge_project = "matrices"
   
   gem.files         = `git ls-files`.split($/)
#    gem.files = `git ls-files`.split("\n")
   gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
#    gem.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
   gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
#    gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
   gem.require_paths = ["lib"]
  
   gem.add_development_dependency "rake"
   gem.add_development_dependency "rspec"
   gem.add_development_dependency "guard-rspec"
   gem.add_development_dependency "guard-bundler"
end
