module TeRex
  module Corpus
    class Body

      attr_reader :set, :sample_size, :training, :testing, :format_klass, :category_klass

      def initialize(glob: "", format_klass: NilClass, category_klass: NilClass)
        @glob = glob
        @format_klass = format_klass
        @category_klass = category_klass
      end

      def build
        define_set
        @training = partition_train
        @testing = partition_test
      end

      def define_set
        @set ||= Dir[@glob].map do |file|
          @format_klass.new(file)
        end
        @sample_size = (@set.count * 0.75).round
        @set
      end

      def partition_train
        @set[0..@sample_size].map do |file|
          file.scanner
        end.flatten
      end

      def partition_test
        @set[(@sample_size - 1)..-1].map do |file|
          file.scanner
        end.flatten
      end

    end
  end
end


