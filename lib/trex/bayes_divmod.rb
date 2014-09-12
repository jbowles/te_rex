#
# Refactor of Matt Mower's (Copyright 2005 Matt Mower <self@mattmower.com>) port of 
# the Divmod project Bayesian Classifier (which is Copyright 2003 Amir Bakhtiar <amir@divmod.org>)
#

module Trex
  module Classifier
    class BayesDivmod

      attr_accessor :token_count, :train_count, :name

      def initialize(name: "", pool: nil)
        @name = name
        @traning = []
        @pool = pool
        @data = Hash.new(0.0)
        @token_count = 0
        @train_count = 0
      end

    end
  end
end
