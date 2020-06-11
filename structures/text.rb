class Text
  attr_accessor :sentences

  def self.new text=nil
    return Text.create_from_string text if text.is_a? String
    super
  end

  def initialize text=nil
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
    return false unless @sentences.length == text.sentences.length
    for i in 0..@sentences.length do
      return false unless @sentences[i] == text.sentences[i]
    end
    true
  end

  private
  def self.create_from_string string
    array = string.split /([\.,!?:;\-'"…]+)/
    Text.new array.map { |s| Sentence.new s }
  end
end