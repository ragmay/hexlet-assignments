# frozen_string_literal: true

# BEGIN
def anagramm_filter(word, array)
  array.filter_map { |el| el if el.chars.sort == word.chars.sort }
end
# END
