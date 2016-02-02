#
# Refactor of Lucas Carlson's classifier https://github.com/cardmagic/classifier (Copyright (c) 2005 lucas@rufy.com)
#
module TeRex
  module Classifier
    class Bayes

      attr_reader :category_counts, :total_words, :messages

      # categories = [{:tag => "Thing1", :msg => "Thing1 message"}, {:tag => "Thing2", :msg => "Thing2 message"}]
      # initialize({:tag => "Refund", :msg => "You'll get a refund"}, {:tag => "Nonrefund", :msg => "You won't get a refund"})
      def initialize(*categories)
        @clasif = Hash.new
        @messages = Hash.new
        categories.each {|cat| @clasif[TeRex::Format.category_term(cat[:tag])] = Hash.new}
        categories.each {|cat| @messages[cat[:tag]] = cat[:msg]}
        @total_words = 0
        @category_counts = Hash.new(0)
        @category_wc_hashes = [{}]
      end

      def train(ctgry, text)
        category = TeRex::Format.category_term(ctgry)
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
        tag = (classifications(text).sort_by{|a| -a[1]})[0][0]
        [tag, @messages[tag]]
      end

      def categories
        @categories ||= begin
          @clasif.keys.collect {|c| c.to_s}
        end
      end

  #def classify_and_summarize_plain_text text
  #  word_stems = text.downcase.scan(/[a-z]+/)
  #  scores = Array.new(@category_names.length)
  #  @category_names.length.times {|i|
  #    scores[i] = score(@category_wc_hashes[i], word_stems)
  #  }
  #  best_index = scores.index(scores.max)
  #  best_hash = @category_wc_hashes[best_index]
  #  breaks = sentence_boundaries(text)
  #  sentence_scores = Array.new(breaks.length)
  #  breaks.length.times {|i| sentence_scores[i] = 0}
  #  breaks.each_with_index {|sentence_break, i|
  #    tokens = text[sentence_break[0]..sentence_break[1]].downcase.scan(/[a-z]+/)
  #    tokens.each {|token| sentence_scores[i] += best_hash[token]}
  #    sentence_scores[i] *= 100.0 / (1 + tokens.length)
  #  }
  #  score_cutoff = 0.8 * sentence_scores.max
  #  summary = ''
  #  sentence_scores.length.times {|i|
  #    if sentence_scores[i] >= score_cutoff
  #      summary << text[breaks[i][0]..breaks[i][1]] << ' '
  #    end
  #  }
  #  [@category_names[best_index], summary.strip]
  #end

      def classify_and_summarize text
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
        #tag = score.sort_by{|a| -a[1]}[0][0]
        #[tag, @messages[tag], summary.strip]
      end

      def sentence_boundaries text
        boundary_list = []
        start = index = 0
        current_token = ''
        text.each_char {|ch|
          if ch == ' '
            current_token = ''
          elsif ch == '.'
            current_token += ch
            if !TeRex::StopWord::HUMAN_NAME_PREFIXES_OR_ABREVIATIONS.member?(current_token) && !TeRex::StopWord::DIGITS.member?(current_token[-2..-2])
              boundary_list << [start, index]
              current_token = ''
              start = index + 2
            else
              current_token += ch
            end
          elsif ['!', '?'].member?(ch)
              boundary_list << [start, index]
              current_token = ''
              start = index + 2
          else
            current_token += ch
          end
          index += 1
        }
        boundary_list
      end

      ## Testing and/or Debugging stuff
      def training_description
        max_threshold = (@total_words/self.category_counts.keys.count).to_f
        tmp = []
        @clasif.each_pair do |term,val|
          cc = self.category_counts[term]
          train_ratio = (@total_words/cc).to_f
          tmp << [(train_ratio >= max_threshold), term, "description" => {"training_ratio" => "#{train_ratio}", "threshold" => "#{max_threshold}", "category_counts" => "#{cc}", "total_words" => "#{@total_words}"}]
        end
        tmp
      end

      def under_trained?
        training_description.select {|ut| ut.first == true}
      end

    end
  end
end
