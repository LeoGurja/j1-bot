require_relative './boot'

client = TwitterApi.new

client.parsed_tweets.each do |string|
  begin
    text = Text.new string
    translation = Translator.translate text
    Logger.success text.to_s, translation.to_s
  rescue NotImplementedError
    Logger.error text.to_s
  end
end