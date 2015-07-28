package org.tartarus.snowball;

public class Stemmer {
  private SnowballStemmer stemmer;

  public void nativeInit(String language, String encoding) throws Exception {
    Class stemClass = Class.forName("org.tartarus.snowball.ext." +
        language + "Stemmer");
    this.stemmer = (SnowballStemmer) stemClass.newInstance();
  }

  public String stem(String word) {
    stemmer.setCurrent(word);
    stemmer.stem();
    return stemmer.getCurrent();
  }
}
