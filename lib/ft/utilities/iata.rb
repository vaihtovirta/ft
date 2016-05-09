module FT
  module Utilities
    module Iata
      include FT::DictorinariesContainer::Cities

      DEFAULT_IATA_CODE = "LED".freeze

      private_constant :DEFAULT_IATA_CODE

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
