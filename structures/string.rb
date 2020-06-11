class String
  def punctuation?
    self =~ /[\.,\-'":;]+/
  end

  def gender
    translation = Translator.translations[self]
    translation&.[]('gender') || end_with?(/as?/) ? 'f' : 'm' # guess
  end
  
  def number
    translation = Translator.translations[self]
    translation&.[]('number') || end_with?('s') ? 'more' : 'one' # guess
  end
end