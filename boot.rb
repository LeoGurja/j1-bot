require 'twitter'
require 'yaml'
require 'byebug'
require 'digest'

Dir[File.join(File.dirname(__FILE__), 'structures/*.rb')].each { |f| require f }
Dir[File.join(File.dirname(__FILE__), 'services/*.rb')].each { |f| require f }