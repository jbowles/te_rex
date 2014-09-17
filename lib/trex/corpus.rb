module Trex
  module Corpus
    class Body

      attr_accessor :files, :sample_size

      def initialize(glob, klass)
        @glob = glob
        @klass = klass
      end

      def files
        @files ||= Dir[@glob].map do |file|
          @klass.new(file)
        end
        @sample_size = (@files.count * 0.75).round
        @files
      end

      def train_sentences
        @files[0..@sample_size].map do |file|
          file.scanner
        end.flatten
      end

      def test_sentences
        @files[(@sample_size - 1)..-1].map do |file|
          file.scanner
        end.flatten
      end

    end
  end
end

# pos_corpus = Trex::Corpus::Body.new('corpi/movie_review/pos/cv**', Trex::Corpus::MovieReviewFile)
# pos_corpus.files
# pos_corpus.sample_size
# pos_train = pos_corpus.train_sentences
# pos_test = pos_corpus.test_sentences
#
#
#
#corpus = Trex::Corpus::Body.new('corpi/brown/c*', Trex::Corpus::BrownFile)
