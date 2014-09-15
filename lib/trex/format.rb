
module Trex
  class Format

    class << self
      def category_term(t)
        t.capitalize.intern
      end
    end

  end
end
