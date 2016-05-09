module FT
  class OptionsPresenter
    include FT::Utilities::Iata,
            FT::DictorinariesContainer::PassengerCountWords,
            FT::DictorinariesContainer::TripClasses

    DEFAULT_ECONOMY_CLASS = "Y".freeze
    DEFAULT_TIMEZONE = "Europe/Moscow".freeze

    private_constant :DEFAULT_ECONOMY_CLASS, :DEFAULT_TIMEZONE

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
      target = find_by_attribute(passenger_count_words, :passenger_count)

      target[:count] || 1
    end

    def trip_class
      target = find_by_attribute(trip_classes, :trip_class)

      target[:code] || DEFAULT_ECONOMY_CLASS
    end

    def date
      FT::DateParser.new(
        date: read_assoc(:date),
        range_date: read_assoc(:range_date),
        time_in_words: read_assoc(:time_in_words),
        weekend_word: read_assoc(:weekend_word),
        timezone: timezone
      ).call
    end

    def segments
      return round_trip_segment if read_assoc(:range_date)

      one_way_segment
    end

    private

    def read_assoc(attribute)
      association.assoc(attribute)&.last
    end

    def find_by_attribute(collection, target_attribute, record_attribute = :name)
      collection.shuffle.detect do |words|
        words[record_attribute] == read_assoc(target_attribute)
      end || {}
    end

    def timezone
      current_location = find_by_attribute(cities, :origin)

      current_location[:timezone] || DEFAULT_TIMEZONE
    end

    def one_way_segment
      [{ date: date, destination: destination, origin: origin }]
    end

    def round_trip_segment
      [
        {
          date: date.first,
          destination: destination,
          origin: origin
        },
        {
          date: date.last,
          destination: origin,
          origin: destination
        }
      ]
    end
  end
end
