require "active_support/core_ext/date"
require "active_support/core_ext/numeric/time"
require "active_support/core_ext/time"

module FT
  class DateParser
    include FT::DictorinariesContainer::TimesInWords

    STRFTIME = "%Y-%m-%d".freeze

    attr_reader :date,
                :range_date,
                :time_in_words,
                :weekend_word,
                :timezone,
                :parsed_date

    def initialize(date: nil, range_date: nil, time_in_words: nil, weekend_word: nil, timezone: nil)
      @date = date
      @range_date = range_date
      @time_in_words = time_in_words
      @weekend_word = weekend_word
      @timezone = timezone
    end

    def call
      process_date
      apply_timezone
    end

    private

    def process_date
      @parsed_date ||= begin
        if date
          parse(date)
        elsif range_date
          [parse(range_date.first), parse(range_date.last)]
        elsif time_in_words
          word_to_date(time_in_words)
        elsif weekend_word
          weekend_date
        else
          Time.now
        end
      end
    end

    def apply_timezone
      [parsed_date].flatten.map do |time|
        time.in_time_zone(timezone).strftime(STRFTIME)
      end
    end

    def parse(string_date)
      Date.parse(string_date)
    end

    def word_to_date(time_in_words)
      record = FuzzyMatch.new(times_in_words, read: :name).find(time_in_words)
      record[:days_from_today].days.from_now
    end

    def weekend_date
      Date.today.beginning_of_week(:sunday)
    end
  end
end
