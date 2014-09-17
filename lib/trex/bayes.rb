#
# Refactor of Lucas Carlson's classifier (Copyright (c) 2005 lucas@rufy.com)
#

module Trex
  module Classifier
    class Bayes

      attr_accessor :category_counts, :total_words

      def initialize(*categories)
        @clasif = Hash.new 
        categories.each {|cat| @clasif[Trex::Format.category_term(cat)] = Hash.new}
        @total_words = 0
        @category_counts = Hash.new(0)
      end

      def train(ctgry, text)
        category = Trex::Format.category_term(ctgry)
        @category_counts[category] += 1

        BayesData.index_frequency(text).each do |word, count| 
          @clasif[category][word] ||= 0
          @clasif[category][word] += count

          @total_words += count
        end
      end

      def classifications(text)
        score = Hash.new
        training_count = @category_counts.values.inject {|x,y| x+y}.to_f

        @clasif.each do |category, category_words|
          score[category.to_s] = 0
          total = category_words.values.inject(0) {|sum, element| sum+element}
          BayesData.index_frequency(text).each do |word, count|
            s = category_words.has_key?(word) ? category_words[word] : 0.1
            score[category.to_s] += Math.log(s/total.to_f)
          end

          k = @category_counts.has_key?(category) ? @category_counts[category] : 0.1
          score[category.to_s] += Math.log(k/training_count)
        end

        score
      end

      def classify(text)
        (classifications(text).sort_by{|a| -a[1]})[0][0]
      end

      def categories
        @classif.keys.collect {|c| c.to_s}
      end

      def training_description
        max_threshold = (@total_words/self.category_counts.keys.count).to_f
        tmp = []
        @clasif.each_pair do |term,val|
          cc = self.category_counts[term]
          train_ratio = (@total_words/cc).to_f
          tmp << [(train_ratio > max_threshold), term, "description" => {"training_ratio" => "#{train_ratio}", "threshold" => "#{max_threshold}", "category_counts" => "#{cc}", "total_words" => "#{@total_words}"}]
        end
        tmp
      end

      def under_trained?
        training_description.select {|ut| ut.first == true}
      end

    end
  end
end
