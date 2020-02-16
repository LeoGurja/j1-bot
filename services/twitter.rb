require 'twitter'
require 'yaml'

class TwitterApi
    def initialize
        @credentials = YAML.load_file('services/secret.yml')
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
            tweet.text.gsub(/https:.*\z/, '')
        end
    end
end