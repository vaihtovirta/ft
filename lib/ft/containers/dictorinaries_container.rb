require "daybreak"
require "pry"
require "active_support/core_ext/string"

module FT
  module DictorinariesContainer
    SIMPLE_DICTORINARIES = %i(
      digits
      finish_pps
      froms
      start_pps
      tos
      weekends
    ).freeze

    COMPLEX_DICTORINARIES = %i(
      passenger_count_words
      trip_classes
      months
      times_in_words
      cities
    ).freeze

    ALL_DICTORINARIES = SIMPLE_DICTORINARIES + COMPLEX_DICTORINARIES

    private_constant :ALL_DICTORINARIES

    module All
      ALL_DICTORINARIES.each do |dictorinary|
        define_method dictorinary do
          FT.database[dictorinary]
        end

        next unless COMPLEX_DICTORINARIES.include?(dictorinary)

        define_method "#{dictorinary}_names" do
          FT.database[dictorinary].map { |record| record[:name] }
        end
      end
    end

    ALL_DICTORINARIES.each do |dictorinary|
      class_eval %(
        module #{dictorinary.to_s.camelize}
          def #{dictorinary}
            FT.database[:#{dictorinary}]
          end
        end
      )
    end
  end
end
