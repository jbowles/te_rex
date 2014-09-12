require 'yaml'

module Trex
  class StopWord
    def initialize(path: nil)
      @@stop_words = path.nil? ? YAML::load(File.open("../../corpi/stopwords.yml")) : YAML::load(File.open(path))
    end
  end
end
