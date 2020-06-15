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
      return value if string =~ Regexp.new("^#{key}$", 'i')
    end
    nil
  end

  def method_missing name, *args
    @hash.send name, *args
  end
end