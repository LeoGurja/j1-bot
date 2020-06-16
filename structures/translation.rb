class Translation
  def self.new hash
    return nil unless hash
    super
  end

  def initialize hash
    @hash = hash
  end

  def [](string)
    @hash.each do |key, value|
      return Translation.new(value) if string =~ Regexp.new("^#{key}$", 'i')
    end
    nil
  end

  def translate word
    @hash['always'] || @hash[word.number]
  end

  def method_missing name, *args
    @hash.send name, *args
  end
end