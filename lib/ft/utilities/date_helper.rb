module FT
  module Utilities
    module DateHelper
      extend FT::DictorinariesContainer
      include FT::DictorinariesContainer

      load_dictorinaries [:times_in_words]

      DAY_IN_SECONDS = 86_400
      STRFTIME = "%Y-%m-%d".freeze

      def parse_date(string_date)
        Date.parse(string_date).strftime(STRFTIME)
      end

      def word_to_date(time_in_words)
        record = FuzzyMatch.new(times_in_words, read: :name).find(time_in_words)
        (Time.now + record[:days_from_today] * DAY_IN_SECONDS).strftime(STRFTIME)
      end

      def weekend_date
        today = Time.now
        days_to_weekend = ((6 - today.wday) % 7)

        (today + days_to_weekend * DAY_IN_SECONDS).strftime(STRFTIME)
      end

      def date_now
        Time.now.strftime(STRFTIME)
      end
    end
  end
end
