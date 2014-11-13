module TeRex
  module Corpus
    class Body

      attr_reader :set, :sample_size, :training, :testing, :format_klass, :category_klass

      def initialize(glob: "", partition: :file, format_klass: NilClass, category_klass: NilClass)
        @glob = glob
        @format_klass = format_klass
        @category_klass = category_klass
        @partition = partition
      end

      #@sample_size = (@set.count * 0.75).round
      def build
        define_set
        case @partition
        when /file/
          @sample_size = (@set.count.to_f * 0.75).round
          @training = partition_training_by_file
          @testing = partition_test_by_file
        else
          #super_set = build_superset
          corpus_set = partition_files_for_sentence
          #@sample_size = (superset.count.to_f * 0.75).round
          @sample_size = 0.0
          @training = partition_training_by_sentence(corpus_set)
          @testing = partition_test_by_sentence(corpus_set)
        end
      end

      def define_set
        @set ||= Dir[@glob].map do |file|
          @format_klass.new(file)
        end
        @set
      end

      def partition_training_by_file
        @set[0..@sample_size].map do |file|
          file.scanner
        end.flatten
      end

      def partition_test_by_file
        @set[(@sample_size - 1)..-1].map do |file|
          file.scanner
        end.flatten
      end

      def partition_files_for_sentences
        @set.map do |file|
          file.scanner
        end.flatten
      end

      def partition_training_by_sentence(c_set)
        c_set.sample(c_set.count * 0.75)
      end

      def partition_test_by_sentence(c_set)
        c_set.sample(c_set.count * 0.25)
      end

      def build_superset
        @set.reduce() do |memo,formatter|
          memo << formatter.sentences
        end.flatten
      end

    end
  end
end


