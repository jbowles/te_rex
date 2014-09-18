module Trex
  module Corpus
    require 'drb/drb'
    class Body
    attr_accessor :files, :sample_size, :training, :testing, :drb_server

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
      @drb_server = DRb.start_service("druby://localhost:8787", @klass.new)
      @files ||= Dir[@glob].map {|f| f}
      @sample_size = (@files.count * 0.75).round
      @files
    end

    def partition_train
      @files[0..@sample_size].map do |file|
        @drb_server.front.scan(file)
      end.flatten
    end

    def partition_test
      @files[(@sample_size - 1)..-1].map do |file|
        @drb_server.front.scan(file)
      end.flatten
    end

    end
  end
end


