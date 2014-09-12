require 'fast_stemmer'

module Trex
  module Classifier
    class BayesData
      class << self
        # Remove punctuation. 
        def remove_punct(s)
          s.gsub(/(\,)|(\?)|(\.)|(\!)|(\;)|(\:)|(\")|(\@)|(\#)|(\$)|(\%)|(\^)|(\&)|(\*)|(\()|(\))|(\_)|(\=)|(\+)|(\[)|(\])|(\\)|(\|)|(\<)|(\>)|(\/)|(\`)|(\{)|(\})/, ' punct ')
        end

        def remove_date_time_money(s)
          s.gsub(/(\d{2}\w{3}\d{2})|(\d{2}\:\d{2})|(\d{2,4}\-\d{2,4}-\d{2,4})|(\d{1,3}\/\d{2,4}\/\d{2,4}|(\$\d+(\.\d{2})|(\$\d+)))/, ' datetimemoney ')
        end

        # Return a Hashed Index of words => instance_count. 
        # Each word in the string is interned and shows count in the document.
        def index_frequency(text)
          cfi = clean_stemmed_filtered_index(text)
          cni = clean_naive_index(text)
          cfi.merge(cni)
        end

        # Return a filtered word freq index without extra punctuation or short words
        def clean_filtered_index(text)
          rp = remove_punct(text).gsub(/[^\w\s]/,"")
          filtered_index remove_date_time_money(rp).split
        end

        # Return a word freq index without extra punctuation
        def clean_naive_index(text)
          naive_index remove_punct(text).split
        end

        # Return a filtered word freq index without extra punctuation or short words
        def clean_stemmed_filtered_index(text)
          stemmed_filtered_index remove_punct(text).gsub(/[^\w\s]/,"").split
        end

        private
        # Downcase, filter against stop list, ignore sequences less that 2 chars, and stem words
        def stemmed_filtered_index(word_array)
          idx = Hash.new(0)
          word_array.each do |word|
            word.downcase!
            #if !CORPUS_SKIP_WORDS.include?(word) && word.length > 2
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
            #if !CORPUS_SKIP_WORDS.include?(word) && word.length > 2
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

        @@stop_words = [
          "a",
          "about",
          "above",
          "after",
          "again",
          "against",
          "all",
          "am",
          "an",
          "and",
          "any",
          "are",
          "aren't",
          "as",
          "at",
          "be",
          "because",
          "been",
          "before",
          "being",
          "below",
          "between",
          "both",
          "but",
          "by",
          "could",
          "did",
          "didn't",
          "do",
          "does",
          "doesn't",
          "doing",
          "don't",
          "down",
          "during",
          "each",
          "few",
          "for",
          "from",
          "further",
          "had",
          "hadn't",
          "has",
          "hasn't",
          "have",
          "haven't",
          "having",
          "he",
          "he'd",
          "he'll",
          "he's",
          "her",
          "here",
          "here's",
          "hers",
          "herself",
          "him",
          "himself",
          "his",
          "how",
          "how's",
          "i",
          "i'd",
          "i'll",
          "i'm",
          "i've",
          "if",
          "in",
          "into",
          "is",
          "isn't",
          "it",
          "it's",
          "its",
          "itself",
          "let's",
          "me",
          "more",
          "most",
          "mustn't",
          "my",
          "myself",
          "no",
          "nor",
          "not",
          "of",
          "off",
          "on",
          "once",
          "only",
          "or",
          "other",
          "ought",
          "our",
          "ours",
          "ourselves",
          "out",
          "over",
          "own",
          "same",
          "shan't",
          "she",
          "she'd",
          "she'll",
          "she's",
          "should",
          "shouldn't",
          "so",
          "some",
          "such",
          "than",
          "that",
          "that's",
          "the",
          "their",
          "theirs",
          "them",
          "themselves",
          "then",
          "there",
          "there's",
          "these",
          "they",
          "they'd",
          "they'll",
          "they're",
          "they've",
          "this",
          "those",
          "through",
          "to",
          "too",
          "under",
          "until",
          "up",
          "very",
          "was",
          "wasn't",
          "we",
          "we'd",
          "we'll",
          "we're",
          "we've",
          "were",
          "weren't",
          "what",
          "what's",
          "when",
          "when's",
          "where",
          "where's",
          "which",
          "while",
          "who",
          "who's",
          "whom",
          "why",
          "why's",
          "with",
          "won't",
          "would",
          "wouldn't",
          "you",
          "you'd",
          "you'll",
          "you're",
          "you've",
          "your",
          "yours",
          "yourself",
          "yourselves"
        ]

      end
    end
  end
end
