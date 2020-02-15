require_relative './sentence'

class Text
    def initialize string, translations
        array = string.split /([\.,!?:\-'"])/
        @sentences = array.map { |sentence| Sentence.new sentence, translations }
    end

    def translate
        @sentences.each do |sentence|
            sentence.translate
        end
    end

    def stringify
        output = ''
        @sentences.each do |sentence|
            output << sentence.stringify
            if sentence.punctuation?
                output << ' '
            end
        end
        output
    end
end