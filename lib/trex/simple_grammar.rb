module Trex
  class SimpleGrammar
    # Define composition
    def standard
      std_prefix_star + std_atom + std_suffix_star
    end

    # *_atom will eventually come from `module Atom`
    def std_prefix
      one_of File.load()
      #prefix_atom
    end

    def std_suffix
      one_of File.load()
      #suffix_atom
    end

    #standard prefix
    def std_prefix_star
      return [] if rand(2) == 0
      std_prefix + std_prefix_star
    end

    #standard suffix
    def std_suffix_star
      return [] if rand(2) == 0
      std_suffix + std_suffix_star
    end

    def std_atom
      one_of %w(nursing)
      #standard_atom
    end

    # Retrieve stuff
    def one_of(set)
      # for when we don't want to monkey patch... it's easier to do the recursion
      # when Array is monkey patched so test it out here first, then....
      [std_limit(set)]
    end

    # don't want to monkey patch Array, so do it this way
    def std_limit(std_arr)
      #result = []
      std_arr[rand(std_arr.length)]
    end
  end
end
