# coding: utf-8
#
require './lib/te_rex/version'

Gem::Specification.new do |spec|
  spec.name          = "te_rex"
  spec.version       = TeRex::VERSION
  spec.authors       = ["Joshua Bowles"]
  spec.email         = ["jbowayles@gmail.com"]
  spec.description   = "Simple text processing for small data sets."
  spec.summary       = "Basic NLP stuff for small data sets. Naive Bayes classification and corpora loading."
  spec.homepage      = "https://github.com/jbowles/te_rex"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*.rb"]
  spec.test_files    = Dir["test/**/*.rb"]
  spec.require_paths = ["lib"]

  spec.add_dependency "fast-stemmer", "~> 1.0", ">= 1.0.2"

  spec.add_development_dependency "bundler", "~> 1.5", ">= 1.5.3"
  spec.add_development_dependency "rake", "~> 10.3", ">= 10.3.2"
  spec.add_development_dependency "pry-test", "~> 0.5", ">= 0.5.5"
  spec.add_development_dependency "pry", "~> 0.10", ">= 0.10.1"
  #spec.add_development_dependency "pry-debugger", "~> 0.2", ">= 0.2.3"
  spec.add_development_dependency "pry-rescue", "~> 1.4", ">= 1.4.1"
  spec.add_development_dependency "pry-stack_explorer", "~> 0.4", ">= 0.4.9.1"
  #spec.add_development_dependency "simplecov"
end

