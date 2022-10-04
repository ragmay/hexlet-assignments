# frozen_string_literal: true

# BEGIN
def get_same_parity(array)
  return [] if array.empty?

  array.select { |number| number.even? == array[0].even? }
end
# END
