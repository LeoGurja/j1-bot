require_relative './translations/translate'

t = Translate.new './translations.yml'
text = ARGV[0] || 'Primeira morte ligada ao coronavírus fora da Ásia é confirmada na França'
puts text
begin
    translation = t.translate text
    puts t.translate text
rescue NotImplementedError
    puts text, 'Não foi possível traduzir'
end