class Sentence
  attr_accessor :words

  def self.new sentence=nil
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

  private
  def self.create_from_string string
    array = string.split ' '
    Sentence.new array
  end
end