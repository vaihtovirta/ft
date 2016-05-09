require "damerau-levenshtein"

module FT
  module LevenshteinContainer
    def levenshtein
      @levenshtein ||= DamerauLevenshtein
    end
  end
end
