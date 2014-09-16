require_relative "trex/format"
require_relative "trex/stop_word"
require_relative "trex/alpha_num"
require_relative "trex/bayes_data"
require_relative "trex/bayes"

module Trex
  def self.load_training_modules
    Dir["#{File.dirname(__FILE__)}/train/**/*.rb"].each { |f| load(f) if !!(f =~ /^[^\.].+\.rb/)}
  end

  load_training_modules

end
