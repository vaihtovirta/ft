module FT
  class OptionsPresenter
    extend FT::DictorinariesContainer
    include FT::Utilities::DateHelper,
            FT::Utilities::Iata,
            FT::DictorinariesContainer

    load_dictorinaries %i(passenger_count_words trip_classes)

    ECONOMY_CLASS = "Y".freeze

    attr_reader :association
    private :association

    def initialize(association)
      @association = association
    end

    def origin
      iata_code(read_assoc(:origin) || read_assoc(:city))
    end

    def destination
      iata_code(read_assoc(:destination))
    end

    def passenger_count
      target = passenger_count_words.shuffle.detect do |words|
        words[:name] == read_assoc(:passenger_count)
      end || {}

      target[:count] || 1
    end

    def trip_class
      target = trip_classes.shuffle.detect do |words|
        words[:name] == read_assoc(:trip_class)
      end || {}

      target[:code] || ECONOMY_CLASS
    end

    def date
      return parse_date(read_assoc(:date)) if read_assoc(:date)
      return word_to_date(read_assoc(:time_in_words)) if read_assoc(:time_in_words)
      return weekend_date if read_assoc(:weekend_word)

      date_now
    end

    def start_date
      parse_date(read_assoc(:range_date).first)
    end

    def finish_date
      parse_date(read_assoc(:range_date).last)
    end

    def segments
      return round_trip_segment if read_assoc(:range_date)

      one_way_segment
    end

    private

    def read_assoc(attribute)
      association.assoc(attribute)&.last
    end

    def one_way_segment
      [{ date: date, destination: destination, origin: origin }]
    end

    def round_trip_segment
      [
        {
          date: start_date,
          destination: destination,
          origin: origin
        },
        {
          date: finish_date,
          destination: origin,
          origin: destination
        }
      ]
    end
  end
end
