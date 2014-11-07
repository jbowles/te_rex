module TeRex
  module Corpus
    class Body

      attr_reader :files, :sample_size, :training, :testing

      def initialize(glob, klass)
        @glob = glob
        @klass = klass
      end

      def build
        get_files
        @training = partition_train
        @testing = partition_test
      end

      def get_files
        @files ||= Dir[@glob].map do |file|
          @klass.new(file)
        end
        @sample_size = (@files.count * 0.75).round
        @files
      end

      def partition_train
        @files[0..@sample_size].map do |file|
          file.scanner
        end.flatten
      end

      def partition_test
        @files[(@sample_size - 1)..-1].map do |file|
          file.scanner
        end.flatten
      end

    end
  end
end


