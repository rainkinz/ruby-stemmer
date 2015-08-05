require 'java'
require 'lingua/ruby-stemmer'


module Lingua
  StemmerError = Class.new(RuntimeError)

  class Stemmer
    LANG_LOOKUP = {
      'en' => 'english',
      'fr' => 'french',
      'de' => 'german',
      'ro' => 'russian',
      'latin' => 'porter'
    }

    def native_init(lang_code, encoding)
      language = language_for_code(lang_code)
      @stemmer = org.tartarus.snowball.Stemmer.new
      @stemmer.native_init(language, encoding)
    end

    def stem(word)
      @stemmer.stem(word)
    end

    private

    def language_for_code(lang_code)
      LANG_LOOKUP.fetch(lang_code) {
        raise StemmerError, "Could not find implementation for '#{lang_code}'"
      }
    end

  end
end
