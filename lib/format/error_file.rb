module TeRex
  module Format
    require 'csv'
    class ErrorFile

      attr_reader :sentences, :path, :category

      @@csv_conf = {:headers => true}

      def initialize(file_path, klass)
        @path = file_path
        @category = klass
      end

      # Each row of csv as Array object, strip it and return 
      def scanner
        accumulator = []
        CSV.foreach(@path, @@csv_conf) do |row|
          next if row.empty?
          stripped_line = row[0].strip
          unless stripped_line.nil? || stripped_line.empty?
            accumulator << stripped_line
          end
        end
        @sentences ||= accumulator
      end

    end
  end
end
