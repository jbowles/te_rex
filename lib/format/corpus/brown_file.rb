module Trex
  module Format
    require 'drb/drb'
    class BrownFile
      include DRb::DRbUndumped

      attr_accessor :sentences

      def initialize
        @drb_uri = "druby://localhost:8787"
      end

      # Each line of file with Array object,
      # strip it, split by whitespace, map it,
      # split words by '/' to separate POS tags,
      # join by whitespace
      def scan(path)
        @sentences ||= File.open(@path) do |file|
          file.each_line.each_with_object([]) do |line, acc|
            stripped_line = line.strip

            unless stripped_line.nil? || stripped_line.empty?
              acc << line.split(' ').map do |word|
                word.split('/').first
              end.join(' ')
            end
          end
        end

      end
    end
  end
end
