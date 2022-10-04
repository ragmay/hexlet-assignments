# frozen_string_literal: true

# BEGIN
def fibonacci(number)
  return nil if number.negative?
  return 0 if number.zero?
  return 1 if number == 1

  number_one = 0
  number_two = 1
  number.times do
    number_one, number_two = number_two, number_one + number_two
  end

  number_one
end
# END
