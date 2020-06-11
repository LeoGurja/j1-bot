require 'twitter'
require 'yaml'

Dir[File.join(File.dirname(__FILE__), 'structures/*.rb')].each { |f| require f }
Dir[File.join(File.dirname(__FILE__), 'services/*.rb')].each { |f| require f }