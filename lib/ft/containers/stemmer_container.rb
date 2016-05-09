require "lingua/stemmer"

module FT
  module StemmerContainer
    def stemmer
      @stemmer ||= Lingua::Stemmer.new(language: :ru)
    end
  end
end
