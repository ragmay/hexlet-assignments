# frozen_string_literal: true

# BEGIN
def fizz_buzz(start, stop)
  return nil if start > stop

  (start..stop).to_a.map do |number|
    fizz = (number % 3).zero?
    buzz = (number % 5).zero?
    if fizz && buzz
      'FizzBuzz'
    elsif buzz
      'Buzz'
    elsif fizz
      'Fizz'
    else
      number
    end
  end.join(' ')
end
# END
