module Trex
  module Corpus
    class MovieReviewFile

      attr_accessor :sentences

      def initialize(file_path)
        @path = file_path
      end

      def scanner
        @sentences ||= File.open(@path) do |file|
          file.each_line.each_with_object([]) do |line, acc|
            stripped_line = line.strip

            unless stripped_line.nil? || stripped_line.empty?
              acc << line.split(' ').map do |word|
                word.split(' ').first
              end.join(' ')
            end
          end
        end

      end
    end
  end
end

