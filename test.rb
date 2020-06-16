require_relative './boot'

text = Sentence.new ARGV.first

translation = Translator.translate text
puts text.words.inspect
unless text.to_s == translation.to_s
  puts "#{text} => #{translation}"
else
  puts text
end