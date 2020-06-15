require_relative './boot'

text = Text.new ARGV.first

translation = Translator.translate text
unless text.to_s == translation.to_s
  puts "#{text} => #{translation}"
else
  puts text
end