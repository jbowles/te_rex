require 'simplecov'
SimpleCov.command_name 'mt'

SimpleCov.start  do
  add_filter 'test/modules'

  add_group 'Formatter', 'lib/format'
  add_group 'Core', 'lib/te_lrex'
end
