class Text
  attr_accessor :sentences

  def self.new text
    return Text.create_from_string text if text.is_a? String
    super
  end

  def initialize text
    @sentences = text
  end

  def to_s
    output = ''
    @sentences.each do |sentence|
      output << sentence.to_s
      if sentence.punctuation?
        output << ' '
      end
    end
    output.strip
  end

  def ==(text)
    to_s == text.to_s
  end

  def remove word
    @sentences.each do |s|
      s.remove word
    end
  end

  def next_word word
    @sentences.each_with_index do |sentence, index|
      next_word = sentence.next_word word
      return @sentences[index + 1].words[0] if next_word == -1 && @sentences[index + 1]
      return next_word if next_word
    end
  end

  def prev_word word
    @sentences.each_with_index do |sentence, index|
      prev_word = sentence.prev_word word
      return @sentences[index - 1].words[-1] if prev_word == -1 && @sentences[index - 1] && index > 0
      return prev_word if prev_word
    end
  end

  private
  def self.create_from_string string
    array = string.split /([\.,!?:;\-'"…]+)/
    Text.new array.map { |s| Sentence.new s }
  end
end