require_relative './boot'

text = Text.new ARGV.first
begin
  translation = Translator.translate text
  puts "#{text} => #{translation}"
rescue
  puts text
end