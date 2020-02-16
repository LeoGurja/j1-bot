class Sentence
    def initialize string, translations
        @words = string.split ' '
        @translations = translations
    end

    def punctuation?
        @words =~ /[\.,\-'":;]+/
    end
    
    def translate
        @words.each_with_index do |word, index|
            if @translations[word]
                if @translations[word]['gender'] and index > 0
                    handle_gender index - 1, @translations[word]['gender']
                end
                @words[index] = translated_word word
            end
        end
    end

    def translated_word word
        if @translations[word]['always']
            @translations[word]['always']
        else
            number = get_number word
            translation[number]
        end
    end

    def handle_gender index, gender
        found_translation = find_preposition_key @words[index]
        if found_translation
            if found_translation[gender]
                @words[index] = found_translation[gender]
            else
                @words[index] = found_translation['m']
            end
        else
            if @words[index][-1] == 's'
                @words[index][-2] = gender == 'f' ? 'a' : 'o'
            elsif @words[index][-1] == 'o' or @words[index][-1] == 'a'
                @words[index][-1] = gender  == 'f' ? 'a' : 'o'
            end
        end
    end

    def find_preposition_key word
        number = get_number word
        result = nil
        found = false
        @translations['prepositions'].each do |_, prep|
            prep[number].each do |_, value| 
                if value == word
                    found = true
                    break
                end
            end
            if found
                result = prep[number]
                break
            end
        end
        result
    end

    def get_gender word
        if @tranlations[word] && @translations[word][gender]
            @translations[word][gender]
        else
            word.end_with? /as?/ ? 'f' : 'm'
        end
    end

    def get_number word
        if @translations[word] && @translations[word][number]
            @translations[word][number]
        else
            word.end_with?('s') ? 'more' : 'one'
        end
    end

    def stringify
        @words.join(' ')
    end
end