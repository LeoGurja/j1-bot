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
    return false unless @words.length == sentence.words.length
    for i in 0..@words.length do
      return false unless @words[i] == sentence.words[i]
    end
    true
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
    return nil if index <= 0
    @words[index - 1]
  end

  def next_word word
    index = find_index(word)
    return nil if index >= @words.length - 1
    @words[index + 1]
  end

  private
  def find_index word
    @words.each_with_index do |w, i|
      return i if w.object_id == word.object_id
    end
  end

  def self.create_from_string string
    array = string.split ' '
    Sentence.new array
  end
end