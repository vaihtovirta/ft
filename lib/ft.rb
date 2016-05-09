require "fuzzy_match"
require "unicode"
require "ft/version"
require "ft/containers/stemmer_container"
require "ft/containers/dictorinaries_container"
require "ft/containers/levenshtein_container"
require "ft/sentence_processor"
require "ft/tokenizer"
require "ft/recognizer"
require "ft/search_options_builder"
require "ft/utilities/iata"
require "ft/utilities/date_helper"
require "ft/options_presenter"

module FT
  def self.process_sentence(sentence, print = false)
    recognized_sentence = SentenceProcessor.new(sentence).call

    options = SearchOptionsBuilder.new(recognized_sentence).call

    if print
      puts options
    else
      options
    end
  end
end
