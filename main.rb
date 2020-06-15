require_relative './boot'

client = TwitterApi.new

tweets = client.parsed_tweets

tweets.each do |string|
  text = Text.new string
  unless Logger.already_posted? text.to_s
    translation = Translator.translate text
    unless translation.to_s == text.to_s
      Logger.mark_as_posted translation.to_s
      Logger.success text.to_s, translation.to_s
      client.update translation.to_s
    else
      Logger.error text.to_s
    end
  else
    Logger.warning "Já postado: #{text}"
  end
end

Logger.clean_already_posted