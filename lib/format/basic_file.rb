module TeRex
  module Format
    class BasicFile

      attr_reader :sentences, :path, :category

      def initialize(file_path, klass)
        @path = file_path
        @category = klass
      end

      # Each line of file with Array object,
      # strip it, split by whitespace, map it,
      # split words by '/' to separate POS tags,
      # join by whitespace
      def scanner
        @sentences ||= File.open(@path) do |file|
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
