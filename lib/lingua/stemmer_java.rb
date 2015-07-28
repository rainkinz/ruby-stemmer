require 'java'
require 'lingua/ruby-stemmer'


module Lingua
  class Stemmer
    def native_init(language, encoding)
      language = 'english'
      @stemmer = org.tartarus.snowball.Stemmer.new
      @stemmer.native_init(language, encoding)
    end

    def stem(word)
      @stemmer.stem(word)
    end

  end
end
