module FT
  class Tokenizer
    extend Forwardable
    include FT::DictorinariesContainer::All,
            FT::LevenshteinContainer,
            FT::StemmerContainer

    def_delegator :stemmer, :stem

    attr_reader :word
    private :word

    def initialize(word)
      @word = word
    end

    def call
      tokenize_rules.each do |dictorinary, token|
        return token if include?(dictorinary, word)
      end

      nil
    end

    def tokenize_rules
      @tokenize_rules ||= {
        digits => :digit,
        froms => :from,
        tos => :to,
        start_pps => :start_pp,
        finish_pps => :finish_pp,
        weekends => :weekend_word,
        passenger_count_words_names => :passenger_count,
        trip_classes_names => :trip_class,
        months_names => :month,
        times_in_words_names => :time_in_words,
        cities_names => :city
      }
    end

    private

    def include?(dictorinary, word)
      match, dictorinary = normalized_args(dictorinary, word)

      if suitable_to_fuzzy?(match, word)
        match
      else
        dictorinary.include?(word)
      end
    end

    def normalized_args(dictorinary, word)
      [
        Unicode.downcase(FuzzyMatch.new(dictorinary).find(word).to_s),
        dictorinary
          .map { |dict_word| Unicode.downcase(dict_word) }
          .map { |dict_word| stem(dict_word) }
      ]
    end

    def suitable_to_fuzzy?(match, word)
      return if match.empty?

      match.chr == word.chr && acceptable_distance?(match, word)
    end
  end
end
