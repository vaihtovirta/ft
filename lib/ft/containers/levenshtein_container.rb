require "damerau-levenshtein"

module FT
  module LevenshteinContainer
    LEVENSTEIN_DISTANCE = 3

    private_constant :LEVENSTEIN_DISTANCE

    def acceptable_distance?(match, word)
      DamerauLevenshtein.distance(match, word) <= LEVENSTEIN_DISTANCE
    end
  end
end
