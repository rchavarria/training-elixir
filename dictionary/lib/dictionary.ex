defmodule Dictionary do

  alias Dictionary.{WordList, WordsOfLength}

  defdelegate start(), to: WordList
  defdelegate random_word(words), to: WordList
  defdelegate words_of_length(words, len), to: WordsOfLength

end
