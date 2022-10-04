# frozen_string_literal: true

# BEGIN
def count_by_years(users)
  users.select { |user| user[:gender] == 'male' }.map { |user| user[:birthday].split('-')[0] }.tally
end
# END
