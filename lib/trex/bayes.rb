#
# Refactor of Lucas Carlson (Copyright (c) 2005 lucas@rufy.com)
#

module Trex
  module Classifier
    class Bayes

      def initialize(*categories)
        @clasif = Hash.new 
        categories.each {|cat| @clasif[format_category_term(cat)] = Hash.new}
        @total_words = 0
        @category_counts = Hash.new(0)
      end

      def format_category_term(t)
        t.capitalize.intern
      end

      def train(ctgry, text)
        category = format_category_term(ctgry)
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

          s = @category_counts.has_key?(category) ? @category_counts[category] : 0.1
          score[category.to_s] += Math.log(s/training_count)
        end

        score
      end

      def classify(text)
        (classifications(text).sort_by { |a| -a[1] })[0][0]
      end

      def categories
        @classif.keys.collect {|c| c.to_s}
      end

    end
  end
end

#
#
# cat = Trex::Classifier::Bayes.new 'Interesting', 'Uninteresting'
# cat.train("interesting", "here are some good words. I hope you love them")
# cat.train("Uninteresting", "here are some bad words, I hate you")
# cat.classify "I hate bad words and you" 
# # returns 'Uninteresting'
#
#
#
# #
#
# cat = Trex::Classifier::Bayes.new 'Refund', 'Norefund', 'PartRefund'
# cat.train("Refund", "ALL RESERVATIONS MUST BE CANCELLED 24 HOURS PRIOR TO HOST TIME UNLESS DEPOSIT REQUIRED IF THIS RESERVATION HAS BEEN MADE ELECTRONICALLY PLEASE CANCEL IT ELECTRONICALLY TO AVOID CONFUSION AND A NO SHOW BILL. POLICY SUBJECT TO CHANGE. ."
# cat.train("NoRefund", "If you cancel or change your reservation after 4:00 PM on 9/11/14, the hotel will charge you for the total cost of your reservation.")
# cat.train("PartRefund", "If you cancel or change your reservation before 6:00 PM on 9/11/14, the hotel will charge you $202. If you cancel or change your reservation after 6:00 PM on 9/11/14, the hotel will charge you for the total cost of your reservation.")
# cat.classify 



# cat.train("Refund", "This rate is non-refundable and cannot be changed or cancelled - if you do choose to change or cancel this booking you will not be refunded any of the payment."
