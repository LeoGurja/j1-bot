require 'yaml'
require_relative '../structures/text'

class Translator
  private_class_method :new

  def self.translate obj
    if obj.is_a? Text
      @translated = translate_text obj
    elsif obj.is_a? Sentence
      @translated = translate_sentence obj
    else
      @translated = translate_word obj
    end

    if @translated == obj
      raise NotImplementedError 
    end
    @translated
  end

  def self.translations
    @translations
  end

  private
  def self.translate_text text
    Text.new text.sentences.map { |sentence| translate_sentence sentence }
  end

  def self.translate_sentence sentence
    Sentence.new sentence.words.map { |word| translate_word word }
  end

  def self.translate_word word
    translation = @translations[word.to_s]
    return word unless translation

    translation['always'] || translation[word.number]
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