#require all files for more reliable test coverage reports
#Dir[File.expand_path("../lib/**/*.rb", __FILE__)].each { |file| require file }

#require 'simplecov'
#SimpleCov.command_name 'mt'

#SimpleCov.start  do
#  #filters.clear
#  #root '../sabre_travel'
#  #add_filter do |src|
#  #  !(src.filename =~ /^#{SimpleCov.root}/) #unless src.filename =~ /sabre_travel/
#  #end
#  #coverage_dir "#{SimpleCov.root}/coverage"
#  add_filter 'test/'
#  add_filter 'test/xml_source_files/'
#  add_filter 'wsdl_files/'
#
#  add_group 'Payloads', 'lib/sabre_travel/xml'
#  add_group 'Core', 'lib/sabre_travel'
#end


