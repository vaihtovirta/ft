module FT
  class SentenceProcessor
    include FT::StemmerContainer
    extend Forwardable

    def_delegator :stemmer, :stem

    attr_reader :sentence, :processed_sentence
    private :sentence, :processed_sentence

    def initialize(sentence)
      @sentence = sentence
    end

    def call
      normalize
      recognize

      processed_sentence
    end

    private

    def normalize
      @processed_sentence = sentence
                            .split("\s")
                            .map { |word| Unicode.downcase(word) }
                            .map { |word| stem(word) }
                            .map { |word| word.tr("ё", "е") }
                            .map { |word| [tokenize(word), word] }
                            .reject { |pair| pair.first.nil? }
    end

    def tokenize(word)
      Tokenizer.new(word).call
    end

    def recognize
      Recognizer.new(processed_sentence).call
    end
  end
end
