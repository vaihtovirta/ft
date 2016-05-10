module FT
  class Recognizer
    include FT::DictorinariesContainer::All

    SIMPLE_TURNS = %i(origin destination start_date finish_date).freeze
    RECOGNIZING_RULES = {
      %i(from city) => :origin,
      %i(to city) => :destination,
      %i(digit month) => :date,
      %i(start_pp digit) => :start_date,
      %i(finish_pp date) => :finish_date,
      %i(start_date finish_date) => :range_date
    }.freeze

    attr_reader :tokenized_array
    private :tokenized_array

    def initialize(tokenized_array)
      @tokenized_array = tokenized_array
    end

    private_constant :RECOGNIZING_RULES, :SIMPLE_TURNS

    def call
      RECOGNIZING_RULES.each do |rule, mapping|
        tokenized_array.each_cons(rule.size) do |group|
          tokens, values, first_index = options(group)

          next unless tokens == rule

          tokenized_array[first_index] = turn(mapping, values)
          tokenized_array.delete(group.last)
        end
      end
    end

    private

    def options(group)
      [
        group.map(&:first),
        group.map(&:last),
        tokenized_array.index(group.first)
      ]
    end

    def turn(mapping, values)
      if SIMPLE_TURNS.include?(mapping)
        simple_turn(mapping, values)
      else
        send(mapping, values)
      end
    end

    def simple_turn(mapping, values)
      [mapping, values.last]
    end

    def date(values)
      month = FuzzyMatch.new(months, read: :name).find(values.last)
      [:date, "#{values.first} #{month[:eng_name]}"]
    end

    def range_date(values)
      finish_date = values.last
      start_date = "#{values.first} #{finish_date.split(' ').last}"
      [:range_date, [start_date, finish_date]]
    end
  end
end
