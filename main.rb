require_relative './boot'

client = TwitterApi.new

def post_tweets
  tweets = client.parsed_tweets

  tweets.each do |string|
    if Logger.already_posted? text
      Logger.warning "Já postado: #{text}"
      next
    end

    text = Sentence.new string
    translation = Translator.translate text

    if translation.to_s == text.to_s
      Logger.error text.to_s
      next
    end

    Logger.mark_as_posted translation.to_s
    Logger.success text.to_s, translation.to_s
    client.update translation.to_s
  end

  Logger.clean_already_posted
end

def every_15_minutes
  last = Time.now
  while true
    yield
    now = Time.now
    _next = [last + 900,now].max
    sleep (_next - now)
    last = _next
  end
end

every_15_minutes { post_tweets }