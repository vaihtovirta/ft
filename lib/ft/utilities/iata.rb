module FT
  module Utilities
    module Iata
      extend FT::DictorinariesContainer
      include FT::DictorinariesContainer

      load_dictorinaries [:cities]

      DEFAULT_IATA_CODE = "LED".freeze

      def iata_code(city)
        city_record(city)[:iata_code] || DEFAULT_IATA_CODE
      end

      private

      def city_record(city)
        FuzzyMatch.new(cities, read: :name).find(city.to_s) || {}
      end
    end
  end
end
