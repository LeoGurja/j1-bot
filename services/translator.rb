class Translator
  private_class_method :new

  def self.translate obj
    @original = obj
    @result = Marshal.load(Marshal.dump(obj)) # creates a hard copy
    translate_sentence @result
  end

  def self.translations
    @translations
  end

  private
  def self.translate_sentence sentence
    sentence.words.map! { |word| translate_word word }
    sentence
  end

  def self.translate_word word
    return word if word.punctuation?

    translation = @translations[word]
    translation = get_multi_translation(word, translation) if translation&.[]('multi')
    return word unless translation

    translation.translate word
  end

  def self.get_multi_translation word, translation
    word = @result.next_word word
    translation = translation[word]
    return unless word && translation
    
    translation = get_multi_translation(word, translation) if translation['multi']
    @result.remove word if translation
    translation
  end
  
  # TODO: readicionar tratamento de genero
  # def self.handle_gender index, gender
  #   return if index < 0
  #   if @prepositions[@words[index]]&.[](gender)
  #     @words[index] = found_translation[gender]
  #   else
  #     @words[index] = found_translation['m']
  #   end
  #   else
  #     if @words[index][-1] == 's'
  #       @words[index][-2] = gender == 'f' ? 'a' : 'o'
  #     elsif @words[index][-1] == 'o' or @words[index][-1] == 'a'
  #       @words[index][-1] = gender  == 'f' ? 'a' : 'o'
  #     end
  #   end
  # end

  def self.load_translations
    hash = {}
    Dir[File.join(File.dirname(__FILE__), '../translations/*.yml')].each do |f|
      hash.merge! YAML.load_file f
    end
    @translations = Translation.new hash
    @prepositions = @translations['_prepositions']
  end
end

Translator.load_translations