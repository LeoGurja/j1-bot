require_relative './translations/translate'
require_relative './services/twitter'
require_relative './logger'

client = TwitterApi.new
t = Translate.new './translations.yml'
successes = Logger.new 'success.txt'
warnings = Logger.new 'warning.txt'
errors = Logger.new 'errors.txt'

client.parsed_tweets.each do |text|
    begin
        translation = t.translate text
        successes.info translation
    rescue NotImplementedError
        warnings.warning text, 'Não houve alteração no seguinte texto:'
    end
end