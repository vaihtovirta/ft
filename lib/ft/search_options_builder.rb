module FT
  class SearchOptionsBuilder
    extend Forwardable

    def_delegators :options_presenter,
                   :passenger_count,
                   :trip_class,
                   :segments

    attr_reader :associated_array, :options_presenter

    def initialize(associated_array)
      @options_presenter = OptionsPresenter.new(associated_array)
    end

    def call
      {
        passengers: {
          adults: passenger_count,
          children: 0,
          infants: 0
        },
        segments: segments,
        trip_class: trip_class
      }
    end
  end
end
