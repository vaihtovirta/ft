require "fuzzy_match"
require "unicode"
require "active_support/core_ext/object"
require "ft/version"
require "ft/errors"
require "ft/containers/dictorinaries_container"
require "ft/containers/levenshtein_container"
require "ft/containers/stemmer_container"
require "ft/utilities/iata"
require "ft/date_parser"
require "ft/options_presenter"
require "ft/recognizer"
require "ft/search_options_builder"
require "ft/sentence_processor"
require "ft/tokenizer"

module FT
  def self.database
    @database ||= Daybreak::DB.new("config/main.db")

    at_exit { @database.close }

    @database
  end

  def self.build_search_options(sentence)
    raise BlankSentenceError, "Sentence is blank" if sentence.blank?

    recognized_sentence = SentenceProcessor.new(sentence).call

    SearchOptionsBuilder.new(recognized_sentence).call
  end
end
