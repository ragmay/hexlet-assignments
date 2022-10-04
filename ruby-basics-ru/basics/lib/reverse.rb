# frozen_string_literal: true

# BEGIN
def reverse(string)
  result = []
  string.each_char do |char|
    result.unshift(char)
  end
  result.join
end
# END
