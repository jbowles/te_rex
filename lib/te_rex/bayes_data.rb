require 'fast_stemmer'

module TeRex
  module Classifier
    class BayesData
      class << self

        # Remove all kinds of explicit punctuation. 
        def remove_punct(s)
          s.gsub(/(\,)|(\?)|(\.)|(\!)|(\;)|(\:)|(\")|(\@)|(\#)|(\$)|(\^)|(\&)|(\*)|(\()|(\))|(\_)|(\=)|(\+)|(\[)|(\])|(\\)|(\|)|(\<)|(\>)|(\/)|(\`)|(\{)|(\})/, '')
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
          #naive_index(text.split)
          #clean_filtered_index(text)
          #clean_stemmed_filtered_index(text)
          cfi = clean_stemmed_filtered_index(text)
          cni = clean_filtered_index(text)
          cfi.merge(cni)
        end

        # Return text with datetime and moneyterms replaced, remove cardinal terms (1st, 23rd, 42nd), remove punctuation and any non-word chars without spaces (/[^\w\s]/)
        def clean(text)
          dt = date_time(text)
          mt = money_term(dt)
          rp = remove_punct(mt) #.gsub(/[^\w\s]/,"")
          remove_cardinal(rp)
        end

        # Return a filtered word freq index with stemmed morphemes and without extra punctuation or short words
        def clean_stemmed_filtered_index(text)
          stemmed_filtered_index clean(text).split
        end

        # Return a filtered word freq index without extra punctuation or short words
        def clean_filtered_index(text)
          filtered_index clean(text).split
        end

        # Return a word freq index without downcasing, stemming, or filtering with stop list
        def clean_naive_index(text)
          naive_index clean(text).split
        end

        private
        # Downcase, filter against stop list, ignore sequences less that 2 chars, and stem words
        def stemmed_filtered_index(word_array)
          idx = Hash.new(0)
          word_array.each do |word|
            word.downcase!
            if !TeRex::StopWord::LIST.include?(word) #&& word.length > 2
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
            if !TeRex::StopWord::LIST.include?(word) #&& word.length > 2
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
