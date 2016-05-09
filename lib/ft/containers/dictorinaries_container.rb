require "daybreak"
require "active_support/core_ext/string"

module FT
  module DictorinariesContainer
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

    private_constant :ALL_DICTORINARIES

    module All
      ALL_DICTORINARIES.each do |dictorinary|
        define_method dictorinary do
          FT.database[dictorinary]
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
