#require 'simplecov'
#SimpleCov.command_name 'mt'
#
#SimpleCov.start  do
#  add_filter 'test/test_modules'
#end

require_relative "format/format"
require_relative "format/corpus/brown_file"
require_relative "format/corpus/basic_file"
require_relative "te_rex/stop_word"
require_relative "te_rex/alpha_num"
require_relative "te_rex/bayes_data"
require_relative "te_rex/bayes"
require_relative "te_rex/corpus"

module TeRex
end
