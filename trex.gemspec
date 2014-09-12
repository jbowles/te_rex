# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'trex/version'

Gem::Specification.new do |spec|
  spec.name          = "trex"
  spec.version       = "0.0.1" #Trex::VERSION
  spec.authors       = ["Joshua Bowles"]
  spec.email         = ["jbowayles@gmail.com"]
  spec.description   = "Simple text processing for small data sets."
  spec.summary       = "Basic NLP stuff for small data sets. Has n-gram, classification, and access to brown corpus."
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*.rb"]
  spec.test_files    = Dir["test/**/*.rb"]
  spec.require_paths = ["lib"]

  #spec.add_dependency "active_support", "~> 4.1.6"
  spec.add_dependency "fast-stemmer", "~> 1.0", ">= 1.0.2"

  spec.add_development_dependency "bundler", "~> 1.5", ">= 1.5.3"
  spec.add_development_dependency "rake", "~> 10.3", ">= 10.3.2"
  spec.add_development_dependency "micro_test", "~> 0.4", ">= 0.4.4"
  spec.add_development_dependency "pry", "~> 0.10", ">= 0.10.1"
  spec.add_development_dependency "pry-debugger", "~> 0.2", ">= 0.2.3"
  spec.add_development_dependency "pry-rescue", "~> 1.4", ">= 1.4.1"
  spec.add_development_dependency "pry-stack_explorer", "~> 0.4", ">= 0.4.9.1"
end
