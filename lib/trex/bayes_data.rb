require 'fast_stemmer'
require 'yaml'

module Trex
  module Classifier
    class BayesData
      class << self

        @@stopwords = Trex::StopWord.load

        # Remove all kinds of explicit punctuation. 
        def remove_punct(s)
          s.gsub(/(\,)|(\?)|(\.)|(\!)|(\;)|(\:)|(\")|(\@)|(\#)|(\$)|(\%)|(\^)|(\&)|(\*)|(\()|(\))|(\_)|(\=)|(\+)|(\[)|(\])|(\\)|(\|)|(\<)|(\>)|(\/)|(\`)|(\{)|(\})/, '')
        end

        # Remove cardinal terms (1st, 23rd, 42nd)
        def remove_cardinal(s)
          s.gsub(/\d+\w{2}/, '')
        end

        # Replace date times with TERM (09MAR04, 02-23-14, 2014/03/05)
        def date_time(s)
          s.gsub(/(^\d+)|(\s\d+(AM|PM))|(\d{2}\w{3}\d{2})|(\d{2}\:\d{2})|(\d{2,4}\-\d{2,4}-\d{2,4})|(\d{1,3}\/\d{2,4}\/\d{2,4})|(\d+\:\d+)/, 'datetime')
        end

        # Replace money types with TERM ($60, 120.00, $423.89)
        def money_term(s)
          s.gsub(/(\$\d+\.\d+)|(\$\d+)|(\d+\.\d+)/, 'moneyterm')
        end

        # Return a Hashed Index of words => instance_count. 
        # Each word in the string is interned and shows count in the document.
        def index_frequency(text)
          cfi = clean_stemmed_filtered_index(text)
          cni = clean_naive_index(text)
          cfi.merge(cni)
        end

        # Return a filtered word freq index without extra punctuation or short words
        # Also remove any non-word chars without spaces (/[^\w\s]/)
        def clean_stemmed_filtered_index(text)
          tx = remove_cardinal(text)
          rp = remove_punct(tx).gsub(/[^\w\s]/,"")
          dt = date_time(rp)
          stemmed_filtered_index money_term(dt).split
        end

        # Return a filtered word freq index without extra punctuation or short words
        # Also remove any non-word chars without spaces (/[^\w\s]/)
        def clean_filtered_index(text)
          tx = remove_cardinal(text)
          rp = remove_punct(tx).gsub(/[^\w\s]/,"")
          dt = date_time(rp)
          filtered_index money_term(dt).split
        end

        # Return a word freq index without extra punctuation
        def clean_naive_index(text)
          naive_index remove_punct(text).split
        end

        private
        # Downcase, filter against stop list, ignore sequences less that 2 chars, and stem words
        def stemmed_filtered_index(word_array)
          idx = Hash.new(0)
          word_array.each do |word|
            word.downcase!
            if !@@stop_words.include?(word) && word.length > 2
              idx[word.stem.intern] += 1
            end
          end

          idx
        end

        # Downcase, filter against stop list, and ignore sequences less that 2 chars.
        def filtered_index(word_array)
          idx = Hash.new(0)
          word_array.each do |word|
            word.downcase!
            if !@@stop_words.include?(word) && word.length > 2
              idx[word.intern] += 1
            end
          end

          idx
        end

        # Count everything in the word array.
        def naive_index(word_array)
          idx = Hash.new(0)
          word_array.each do |word|
            idx[word.intern] += 1
          end

          idx
        end

      end
    end
  end
end
