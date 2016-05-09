require "daybreak"
require "smarter_csv"

task :seed do
  db = Daybreak::DB.new("config/main.db")

  START_PREPOSITIONS = %w(с).freeze
  FINISH_PREPOSITIONS = %w(по).freeze
  FROM_PREPOSITIONS = %w(из).freeze
  TO_PREPOSITIONS = %w(в на).freeze
  TRIP_CLASSES = [
    { name: "бизнес", code: "C" },
    { name: "эконом", code: "Y" }
  ].freeze
  DIGITS = (1..31).to_a.map(&:to_s).freeze
  TIME_IN_WORDS = [
    { name: "послезавтра", days_from_today: 2 }
  ].freeze
  WEEKENDS = %w(выходные).freeze

  db[:cities] = SmarterCSV.process("tasks/support/cities.csv")
  db[:months] = SmarterCSV.process("tasks/support/months.csv")
  db[:passenger_count_words] = SmarterCSV.process("tasks/support/passenger_count_words.csv")
  db[:trip_classes] = TRIP_CLASSES
  db[:start_pps] = START_PREPOSITIONS
  db[:finish_pps] = FINISH_PREPOSITIONS
  db[:froms] = FROM_PREPOSITIONS
  db[:tos] = TO_PREPOSITIONS
  db[:digits] = DIGITS
  db[:times_in_words] = TIME_IN_WORDS
  db[:weekends] = WEEKENDS

  db.compact
  db.flush
  db.close
end
