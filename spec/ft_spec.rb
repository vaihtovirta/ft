require "spec_helper"

describe FT do
  describe "#process_sentence" do
    include FT::Utilities::DateHelper

    subject { described_class.process_sentence(sentence) }

    context "from PAR to LPP on weekend" do
      let(:sentence) { "из Парижа в Лапенранту на выходные" }
      let(:date) { weekend_date }
      let(:expected_response) do
        {
          passengers:
          { adults: 1, children: 0, infants: 0 },
          segments: [{ date: date, destination: "LPP", origin: "PAR" }],
          trip_class: "Y"
        }
      end

      it { is_expected.to eq(expected_response) }
    end

    context "from BKK to DOM with dates" do
      let(:sentence) { "из Бангкока в Доминику с 26 по 29 декабря вдвоём бизнес" }
      let(:start_date) { parse_date("26 dec") }
      let(:finish_date) { parse_date("29 dec") }
      let(:expected_response) do
        {
          passengers:
          { adults: 2, children: 0, infants: 0 },
          segments: [
            { date: start_date, destination: "DOM", origin: "BKK" },
            { date: finish_date, destination: "BKK", origin: "DOM" }],
          trip_class: "C"
        }
      end

      it { is_expected.to eq(expected_response) }
    end

    context "from PAR to LPP on weekend" do
      let(:sentence) { "Париж послезавтра" }
      let(:date) { word_to_date("послезавтра") }
      let(:expected_response) do
        {
          passengers:
          { adults: 1, children: 0, infants: 0 },
          segments: [
            { date: date, destination: "LED", origin: "PAR" }
          ],
          trip_class: "Y"
        }
      end

      it { is_expected.to eq(expected_response) }
    end
  end
end
