require 'yaml'

module Trex
  class StopWord
    def self.load(path: nil)
      return path.nil? ? YAML::load(File.open("../../corpi/stopwords.yml")) : YAML::load(File.open(path))
    end
  end
end
