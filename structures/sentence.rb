class Sentence
  attr_accessor :words

  def self.new sentence
    return Sentence.create_from_string sentence if sentence.is_a? String
    super
  end

  def initialize sentence
    @words = sentence
  end

  def to_s
    @words.join.strip
  end

  def ==(sentence)
    to_s == sentence.to_s
  end

  def remove word
    @words.each_with_index do |w, i|
      if w.object_id == word.object_id
        return @words.delete_at i
      end
    end
  end

  def prev_word word
    index = find_index(word)
    return nil unless index && index > 0

    found_word = @words[index - 1]
    return prev_word(found_word) if found_word&.punctuation?
    found_word
  end

  def next_word word
    index = find_index(word)
    return nil unless index

    found_word = @words[index + 1]
    return next_word(found_word) if found_word&.punctuation?
    found_word
  end

  private
  def find_index word
    @words.each_with_index do |w, i|
      return i if w.object_id == word.object_id
    end
    nil
  end

  def self.create_from_string string
    array = string.split /([\.,!?:;'"…\s]+)/
    Sentence.new array
  end
end