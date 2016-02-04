require 'fast_stemmer'

module TeRex
  module Classifier
    class BayesData
      class << self

        # all kinds of explicit punctuation. 
        def punct(s)
          Regexp.new(/(\,)|(\?)|(\.)|(\!)|(\;)|(\:)|(\")|(\@)|(\#)|(\$)|(\^)|(\&)|(\*)|(\()|(\))|(\_)|(\=)|(\+)|(\[)|(\])|(\\)|(\|)|(\<)|(\>)|(\/)|(\`)|(\{)|(\})/, ' ')
        end

        # all kinds of newlines or big spaces: tab, newline, carraige return
        def big_space(s)
          Regexp.new(/\n|\t|\r/)
        end

        # sequences of whitespace
        def space_seq(s)
          Regexp.new(/\s{2,}/,' ')
        end

        # cardinal (1st, 23rd, 42nd)
        def cardinal(s)
          Regexp.new(/[0-9]{2}[a-z,A-Z]{2}/)
        end

        # date times (09MAR04, 02-23-14, 2014/03/05)
        def datetime(s)
          Regexp.new(/(^\d+)|(\s\d+(AM|PM))|(\d{2}\w{3}\d{2})|(\d{2}\:\d{2})|(\d{2,4}\-\d{2,4}-\d{2,4})|(\d{1,4}\/\d{2,4}\/\d{2,4})|(\d+\:\d+)/)
        end

        # money types ($60, 120.00, $423.89)
        def moneyterm(s)
          Regexp.new(/(\$\d+\.\d+)|(\$\d+)|(\d+\.\d+)/)
        end
      end
    end
  end
end

