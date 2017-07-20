defmodule Dictionary do

  alias Dictionary.{WordList, WordsOfLength}

  defdelegate random_word(), to: WordList
  defdelegate words_of_length(words, len), to: WordsOfLength

end
