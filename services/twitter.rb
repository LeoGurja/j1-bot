class TwitterApi
  def initialize
    @credentials = YAML.load_file(File.join(File.dirname(__FILE__), '../config/secret.yml'))
    @api = Twitter::REST::Client.new do |config|
      config.consumer_key = @credentials['consumer_key']
      config.consumer_secret = @credentials['consumer_secret']
      config.access_token = @credentials['access_token']
      config.access_token_secret = @credentials['access_token_secret']
    end
  end

  def parsed_tweets
    response = @api.user_timeline('g1')
    response.map do |tweet|
      clean_tweet tweet.text
    end
  end

  def clean_tweet text
    remove_mentions_and_tags(remove_retweets(remove_urls(text))).chomp
  end

  def method_missing(name, *args)
    @api.send name, *args
  end

  def remove_urls text
    text.gsub(/https:.*(\s|\z)/i, '').gsub(/glo\.bo\/.*(\s|\z)/i, '')
  end

  def remove_retweets text
  text.gsub(/^RT\s.*:/, '')
  end

  def remove_mentions_and_tags text
    text.gsub /@|#/, ''
  end
end