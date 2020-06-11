class Translation
  def initialize hash
    @hash = hash
  end

  def [](string)
    @hash.each do |key, value|
      return value if string =~ Regexp.new(key, 'i')
    end
    nil
  end
end