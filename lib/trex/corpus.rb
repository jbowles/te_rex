module Trex
  module Corpus
    class Body

      attr_accessor :files, :sample_size, :training, :testing

      def initialize(glob, klass)
        @glob = glob
        @klass = klass
      end

      def build
        get_files
        @training_sentences = partition_train
        @testing_sentences = partition_test
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

# pos_corpus = Trex::Corpus::Body.new('corpora/movie/positive/cv**', Trex::Corpus::MovieReviewFile)
# pos_corpus.files
# pos_corpus.sample_size
# pos_train = pos_corpus.train_sentences
# pos_test = pos_corpus.test_sentences
#
#
#
#corpus = Trex::Corpus::Body.new('corpi/brown/c*', Trex::Corpus::BrownFile)
