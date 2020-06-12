require_relative './boot'

client = TwitterApi.new

tweets = client.parsed_tweets

tweets.each do |string|
  begin
    text = Text.new string
    translation = Translator.translate text
    unless Logger.already_posted? translation.to_s
      Logger.mark_as_posted translation.to_s
      Logger.success text.to_s, translation.to_s
    end
  rescue NotImplementedError
    Logger.error text.to_s
  end
end

Logger.clean_already_posted