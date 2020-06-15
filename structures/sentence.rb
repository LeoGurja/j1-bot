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
    @words.join(' ').strip
  end

  def punctuation?
    @words.length == 1 && @words.first.punctuation?
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
    return nil unless index
    return -1 if index <= 0
    @words[index - 1]
  end

  def next_word word
    index = find_index(word)
    return nil unless index
    return -1 if (@words.length - 1) <= index
    @words[index + 1]
  end

  private
  def find_index word
    @words.each_with_index do |w, i|
      return i if w.object_id == word.object_id
    end
    nil
  end

  def self.create_from_string string
    array = string.split ' '
    Sentence.new array
  end
end