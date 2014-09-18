module Trex
  module Format
    require 'drb/drb'
    class BasicFile
      include DRb::DRbUndumped

      def initialize
        @drb_uri = "druby://localhost:8787" 
      end

      # Each line of file with Array object,
      # strip it, split by whitespace, map it, join
      def scan(path)
        File.open(path) do |file|
          file.each_line.each_with_object([]) do |line, acc|
            stripped_line = line.strip

            unless stripped_line.nil? || stripped_line.empty?
              acc << line.split(' ').map {|word| word}.join(' ')
            end
          end
        end
      end

    end
  end
end
