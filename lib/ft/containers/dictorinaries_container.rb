require "daybreak"

module FT
  module DictorinariesContainer
    DB_NAME = "config/main.db".freeze

    ALL_DICTORINARIES = %i(
      cities
      digits
      finish_pps
      froms
      months
      passenger_count_words
      start_pps
      times_in_words
      tos
      trip_classes
      weekends
    ).freeze

    def load_dictorinaries(dictorinaries = ALL_DICTORINARIES)
      dictorinaries.each do |dictorinary|
        define_method dictorinary do
          database[dictorinary]
        end
      end

    end

    def database
      @database ||= Daybreak::DB.new(DB_NAME)
    end
  end
end
