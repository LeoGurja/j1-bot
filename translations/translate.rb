require 'yaml'
require_relative '../structures/text'

class Translate
    def initialize yaml_file
        @translations = YAML.load_file 'translations/translations.yml'
        @translations['prepositions'] = YAML.load_file 'translations/prepositions.yml'
    end

    def translate string
        original = Text.new string, {}
        @text = Text.new string, @translations
        @text.translate
        output = @text.stringify
        raise NotImplementedError if original.stringify == output
        output
    end
end