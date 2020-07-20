require_relative './boot'

client = TwitterApi.new

def post_tweets(client)
  tweets = client.parsed_tweets
  posted = 0
  puts 'postando tweets...'
  tweets.each do |string|
    break if posted >= 3
    next if Logger.already_posted? string

    text = Sentence.new string
    translation = Translator.translate text

    if translation.to_s == text.to_s
      Logger.error text.to_s
      next
    end

    Logger.mark_as_posted string
    Logger.success text.to_s, translation.to_s
    client.update translation.to_s
    posted += 1
  end
  puts "#{posted}/#{tweets.length} tweets postados"
  Logger.clean_already_posted
end

def every_5_minutes
  last = Time.now
  while true
    yield
    now = Time.now
    _next = [last + 300,now].max
    sleep (_next - now)
    last = _next
  end
end

every_5_minutes { post_tweets(client) }